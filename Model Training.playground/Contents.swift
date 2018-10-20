import Cocoa

var str = "Hello, playground"

import CreateMLUI

if #available(OSX 10.14, *) {
    let builder = MLImageClassifierBuilder()
    builder.showInLiveView()
} else {
    // Fallback on earlier versions
    print("Not available")
}


//if #available(OSX 10.14, *) {
//    let builder = MLImageClassifierBuilder()
//
//} else {
//    // Fallback on earlier versions
//}
