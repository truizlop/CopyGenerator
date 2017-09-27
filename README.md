# Copy Generator

An Xcode Source Editor extension to generate initializers and copy methods for Swift classes and structs.

## How to use

Let's assume you have a Swift `class` or `struct`, similar to this:

```swift
class Person {
  let name : String
  var age : Int
}
```

If you select both fields (including their types) and go to the Editor menu, you can select "Generate initializer and copy method". The extension will then generate the following code:

```swift
class Person {
  let name : String
  var age : Int

  init(name : String, age : Int) {
    self.name = name
    self.age = age
  }

  func copy(name : String? = nil, age : Int? = nil) -> Person {
    return Person(name : name ?? self.name, age : age ?? self.age)
  }
}
```

This will allow you to easily create copies of an object with changes to some fields. For instance:

```swift
let person = Person(name : "Tomás", age : 30)
let agedPerson = person.copy(age : 31)
```

In the snippet above, `person` will have the same fields as person, except the ones we are setting in the copy parameters (`age = 31`).

## How to install this extension

1. Clone this repository and open it in Xcode
2. Archive it (Product > Archive)
3. From the Organizer window, click on Export... > Export as a macOS App
4. Double click the exported file and quit. The extension should be installed now.

## License


    Copyright 2015 Tomás Ruiz-López

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
