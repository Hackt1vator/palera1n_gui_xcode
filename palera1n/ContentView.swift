

import SwiftUI
import Foundation
import Cocoa

struct ContentView: View {
    var body: some View {
        VStack {
            Text("palera1n gui")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Button(action: {
                create()
            }) {
                Text("Create fake fs")
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                boot()
            }) {
                Text("Boot fake fs")
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                rootless()
            }) {
                Text("rootless")
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                dfu()
            }) {
                Text("How to enter dfu")
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
            
            Text("Designed and developed by @hackt1vator")
                .font(.footnote)
                .padding(.bottom, 10)
                .foregroundColor(.gray)
        }
    }
    
}

    

    func shell(_ launchPath: String, _ arguments: [String]) -> (String, Int32) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: launchPath)
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        do {
            try task.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                return (output, task.terminationStatus)
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
        
        return ("", -1)
    }
    
    func boot() {
        showPopupMessage(title: "jailbreak", message: "We will now boot your fake fs! Please put the device into dfu!")
        let (bootfakefs) =
            shell("/bin/zsh", ["-c","cd /Applications && ./palera1n.app/Contents/Resources/boot.sh"])
    }
    
    func create() {
        showPopupMessage(title: "jailbreak", message: "We will now create your fake fs! Please put the device into dfu!")
        let (createfakefs) =
            shell("/bin/zsh", ["-c","cd /Applications && ./palera1n.app/Contents/Resources/create.sh"])
    }

func rootless() {
    showPopupMessage(title: "jailbreak", message: "We will now jailbreak your device rootless! Please put the device into dfu!")
    let (rootless) =
        shell("/bin/zsh", ["-c","cd /Applications && ./palera1n.app/Contents/Resources/rootless.sh"])
}

    func dfu() {
        showPopupMessage(title: "jailbreak", message: "1. Connect your iPhone to the computer.\n2. Press and hold the Side button (Power button) and the Volume Down button simultaneously.\n3. Keep holding both buttons for 5 seconds.\n4. Release the Side button, but continue holding the Volume Down button for another 10 seconds.\n5. Your iPhone is now in DFU mode!")
    }
    

    func showPopupMessage(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
