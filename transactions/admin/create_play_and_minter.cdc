// Transaction to create a Play data and a LimitedMiner to mint NFTs with that Play data
// Sender: Account that has TopShot's Admin resource object

import TopShot from 0xTOPSHOTADDRESS
import TopShotLimitedMinter from 0xTOPSHOTLIMITEDMINTERADDRESS

transaction() {
  prepare(acct: AuthAccount) {
    let admin = acct.borrow<&TopShot.Admin>(from: /storage/TopShotAdmin)
                  ?? panic("No admin resource in storage")

    // Create a Play data
    let metadata = {
      "FullName": "Lou Williams",
      "Birthdate": "1986-10-27",
      "JerseyNumber": "23",
      "TeamAtMoment": "Los Angeles Clippers",
      "DateOfMoment": "2020-01-05 20:30:00 +0000 UTC"
    }
    admin.createPlay(metadata: metadata)

    // Create a Set
    let setName = "Test Set 1"
    admin.createSet(name: setName)

    // Add the Play to the Set
    let setID = UInt32(1)
    let playID = UInt32(1)
    let setRef = admin.borrowSet(setID: setID)
    setRef.addPlay(playID: playID)

    // Create a LimitedMinter
    let minterName = "MinterForLouWilliams"
    TopShotLimitedMinter.addMinter(admin: <- admin.createNewAdmin(), setID: setID, playID: playID, minterName: minterName)
  }
}