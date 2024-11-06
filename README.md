# Minerva

Minerva is a 2D renderer written in Swift inspired by [p5.js](https://p5js.org) and the [CGContext](https://developer.apple.com/documentation/coregraphics/cgcontext). 

## Sketch

In order to be able to render something using Minerva, you need to create a `Sketch`.

```swift

class YourSketch: Sketch {
  override func setup() {
    // called ony once
  }

  override func draw() {
    // called every frame
  }
}
```

And then, inside your view or view controller:

```swift
addSketch(yourSketch)
```

And that's it :)

## Commands

With Minerva you can use different type of "commands", as I call them. 

### Shape

This kind of commands allow you to draw different kinds of shapes.

#### Line

```swift
// ... inside your sketch
override func draw() {
  // draw a line from (100, 100) to (200, 200)
  line(100, 100, 200, 200)
}
```

<img width="288" alt="Screenshot 2024-11-06 at 4 03 02 PM" src="https://github.com/user-attachments/assets/2d48e70e-1d93-4659-a2f3-bbaa0dee0c03">

#### Rect

```swift
// ... inside your sketch
override func draw() {
  // draw a rect at (100, 100) with a width of 50 and height of 30
  rect(100, 100, 50, 30)
}
```

<img width="288" alt="Screenshot 2024-11-06 at 4 13 37 PM" src="https://github.com/user-attachments/assets/a1cc45de-79be-4367-8b5c-0c8a5ee8af2c">

#### Triangle

```swift
// ... inside your sketch
override func draw() {
  // draw triangle at (100, 150), (200, 150) and (150, 50)
  triangle(100, 150, 200, 150, 150, 50)
}
```

<img width="288" alt="Screenshot 2024-11-06 at 5 41 13 PM" src="https://github.com/user-attachments/assets/35a55a55-0db5-4e98-96ed-9a4adbab181f">

### Color

#### Fill

```swift
// ... inside your sketch
override func draw() {
  // set black as the fill color
  fill(0, 0, 0)
  // draw a black rectangle
  rect(0, 0, 100, 300)
}
```

#### background

```swift
// ... inside your sketch
// it's not really necessary to set the background color per frame
override func setup() {
  // set white as the background color
  background(255, 255, 255)
}
```

### Transform

This kind of commands allow you to apply some transformations to the current drawing group.

#### Translate

```swift
// ... inside your sketch
override func draw() {
  // ...
  // translates the coordiantes system by 5 in x and 45 in y
  translate(5, 45)
}
```

#### Rotate

```swift
// ... inside your sketch
override func draw() {
  // ...
  // rotates the coordiantes system by 45 degrees
  rotate(45)
}
```


### Structure

#### Push

```swift
// ... inside your sketch
override func draw() {
  // Creates a new drawing group with the current transformations and fill color.
  push()
}
```

#### Pop

```swift
// ... inside your sketch
override func draw() {
  // Restores the last saved drawing group.
  pop()
}
```

#### Loop

```swift
// ... inside your sketch
override func draw() {
  // Stops the main loop.
  loop()
}
```

#### No loop

```swift
// ... inside your sketch
override func draw() {
  // Stops the main loop.
  noLoop()
}
```

## Examples

Inside the `demo-ios` project, you will find some examples, such as the following: 

| Factal Organic Tree |
|--|
| <img width=200 src="https://github.com/user-attachments/assets/2027d576-df7d-47e1-8450-34ae6c72095d"> |


