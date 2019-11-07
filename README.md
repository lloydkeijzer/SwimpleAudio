# SwimpleAudio
![version](https://img.shields.io/github/v/tag/lloydkeijzer/SwimpleAudio)
![issues](https://img.shields.io/github/issues-raw/lloydkeijzer/SwimpleAudio)
![license](https://img.shields.io/github/license/lloydkeijzer/SwimpleAudio)
![size](https://img.shields.io/github/languages/code-size/lloydkeijzer/SwimpleAudio)

Simple audio playback in Swift.

SwimpleAudio is part of the Swimple packages series. Swimple stands for Simple Swift. These packages make coding with Swift simpler and more convenient.

## Swift Package Manager 📦
From within Xcode 11 or up you can add SwimpleAudio as a Swift Package:

1. Select your project 
2. Go to `Swift packages` 
3. Add a package (+) 
4. Enter `https://github.com/lloydkeijzer/SwimpleAudio.git` as the package repository url
5. Select the version you want to use and click next

You're now able to import SwimpleAudio in your source code 🎉

## Binding audio 🔊
You can easily bind any sound effect to an action of a UIControl object.
```swift
class ViewController: UIViewController {

  let button = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    button.addSound(named: "button_click.mp3", for: .touchUpInside)
  }
  
  deinit {
    button.removeTargets()
  }
}
```
Delaying a sound effect after an UIControl.Event triggers.
```swift
button.addSound(named: "button_click.mp3", for: .touchUpInside, delay: .seconds(3))
```
Repeating a sound effect a number of times after an UIControl.Event triggers.
```swift
button.addSound(named: "button_click.mp3", for: .touchUpInside, repeats: 5)
```
