// Transaction to mint and receive a new NFT
// Sender: Any account


import TopShot from 0xTOPSHOTADDRESS
import TopShotLimitedMinter from 0xTOPSHOTLIMITEDMINERADDRESS

transaction() {
    prepare(acct: AuthAccount) {
        // Performed when there are no collections in this account storage
        if acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection) == nil {
            let collection <- TopShot.createEmptyCollection() as! @TopShot.Collection
            acct.save(<-collection, to: /storage/MomentCollection)
            acct.link<&{TopShot.MomentCollectionPublic}>(/public/MomentCollection, target: /storage/MomentCollection)
        }

        // Mint new NFT of "Lou Williams"
        let minterName = "MinterForLouWilliams"
        let moment <- TopShotLimitedMinter.mintMoment(minterName: minterName)

        // Add minted NFT to the collection
        let collection = acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection)!
        collection.deposit(token: <-moment)
    }
}