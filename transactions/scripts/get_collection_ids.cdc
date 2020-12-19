// This is the script to get a list of all the moments an account owns
// Just change the argument to `getAccount` to whatever account you want
// and as long as they have a published Collection receiver, you can see
// the moments they own.

import TopShot from 0xTOPSHOTADDRESS

pub fun main(account: Address): [UInt64] {
  let addr: Address = 0x01

  let collectionRef = getAccount(addr).getCapability(/public/MomentCollection)!
                          .borrow<&{TopShot.MomentCollectionPublic}>()!
  return collectionRef.getIDs()
}