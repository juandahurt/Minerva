# Minerva

Minerva is a 2D renderer written in Swift inspired by [p5.js](https://p5js.org) and the CGContext. 

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

### Color

### Transform

### Structure

## Examples

Inside the `demo-ios` project, you will find some examples, such as the following: 

| Factal Organic Tree |
|--|
| <img width=200 src="https://github.com/user-attachments/assets/2027d576-df7d-47e1-8450-34ae6c72095d"> |


