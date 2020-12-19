// Transaction to transfer NFTs
// Sender: Account that has NFTs

import NonFungibleToken, TopShot from 0xTOPSHOTADDRESS

transaction() {
    prepare(acct: AuthAccount) {
        let withdrawID: UInt64 = UInt64(1)
        let recipient: Address = 0x03

        let collectionRef = acct.borrow<&TopShot.Collection>(from: /storage/MomentCollection)
            ?? panic("Could not borrow a reference to the stored Moment collection")
        let transferToken <- collectionRef.withdraw(withdrawID: withdrawID)

        let receiverRef = getAccount(recipient).getCapability(/public/MomentCollection)!.borrow<&{TopShot.MomentCollectionPublic}>()!
        receiverRef.deposit(token: <- transferToken)
    }
}