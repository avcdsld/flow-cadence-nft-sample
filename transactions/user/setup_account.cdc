// Transaction to set up account storage to receive NFTs
// Sender: Any account

import TopShot from 0xTOPSHOTADDRESS
import TopShotLimitedMinter from 0xTOPSHOTLIMITEDMINTERADDRESS

transaction() {
    prepare(acct: AuthAccount) {
        // Performed when there are no collections in this account storage
        if acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection) == nil {

            // Create empty collection
            let collection <- TopShot.createEmptyCollection() as! @TopShot.Collection

            // Store the collection to the acount storage
            acct.save(<-collection, to: /storage/MomentCollection)

            // Create a public referrence of the collection
            acct.link<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection, target: /storage/MomentCollection)
        }
    }
}