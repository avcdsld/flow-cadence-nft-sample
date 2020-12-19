import TopShot from 0xTOPSHOTADDRESS

pub contract TopShotLimitedMinter {

    access(self) var minter: @{String: Minter}

    init() {
        self.minter <- {}
    }

    pub resource Minter {
        access(self) let admin: @TopShot.Admin
        access(self) let setID: UInt32
        access(self) let playID: UInt32

        init(admin: @TopShot.Admin, setID: UInt32, playID: UInt32) {
            self.admin <- admin
            self.setID = setID
            self.playID = playID
        }

        pub fun mintMoment(): @TopShot.NFT {
            let setRef = self.admin.borrowSet(setID: self.setID)
            return <- setRef.mintMoment(playID: self.playID)
        }

        destroy() {
            destroy self.admin
        }
    }

    pub fun addMinter(admin: @TopShot.Admin, setID: UInt32, playID: UInt32, minterName: String) {
        self.minter[minterName] <-! create Minter(admin: <- admin, setID: setID, playID: playID)
    }

    pub fun removeMinter(minterName: String, proofOfAdmin: @TopShot.Admin): @TopShot.Admin {
        // If you have admin resource object, you can remove the minter
        let minter <- self.minter.remove(key: minterName) ?? panic("missing Minter")
        destroy minter
        return <- proofOfAdmin
    }

    pub fun mintMoment(minterName: String): @TopShot.NFT {
        let minter <- self.minter.remove(key: minterName) ?? panic("missing Minter")
        let moment <- minter.mintMoment()
        self.minter[minterName] <-! minter
        return <- moment
    }
}