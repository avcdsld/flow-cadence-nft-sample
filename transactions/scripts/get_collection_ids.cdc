// Script to get the NFT list (tokenID list) in the collection of the specified account

import TopShot from 0xTOPSHOTADDRESS

pub fun main(account: Address): [UInt64] {
  let addr: Address = 0x01 // TODO: Change address

  let collectionRef = getAccount(addr).getCapability(/public/MomentCollection)!
                          .borrow<&{TopShot.MomentCollectionPublic}>()!
  return collectionRef.getIDs()
}