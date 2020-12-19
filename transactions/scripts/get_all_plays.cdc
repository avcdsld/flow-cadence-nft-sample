// Script to get an array of all the plays that have ever been created for Top Shot

import TopShot from 0xTOPSHOTADDRESS

pub fun main(): [TopShot.Play] {
    return TopShot.getAllPlays()
}