# Binary-Jigasw-Apple-WWDC25-Swift-Student-Challenge-2025-winner
When I was a child, I was always fascinated by jigsaw puzzles and building blocks. I would arrange them on my grandfather's bed and sit on a little stool for hours, completely absorbed in the fun. As I grew older, the explosion of information filled our lives with constant social media updates, news, and advertisements. I noticed that my cousins and nephews were always scrolling through short videos on their parents’ phones, rarely focusing on doing something creative. Reflecting on my own childhood, I came up with an idea: with Apple's support for student programming and its advanced technology, I could create an innovative puzzle game to give today's children an experience of the simple joy I once cherished. I hope this game will not only be enjoyable for kids but also help improve their concentration. Additionally, by incorporating jigsaw puzzles that involve Boolean logic, I aim to strengthen their visual processing skills. Inspired by the smooth experience of Apple's operating system and enriched with my own hand-drawn elements, I believe this software will showcase a fantastic demo and captivate its young audience.
I hope that children can experience a fun game to improve spatial imagination and logical reasoning, and perhaps can especially help kids with special needs (e.g. ADHD, SPD, NVLD). Binary Jigsaw was born for this as a novel jigsaw puzzle, and let children learn in a relaxing and enjoyable way.
![3a60ee3d58c31a9b986cdb369d96378](https://github.com/user-attachments/assets/5951458d-fcd1-4ccb-9c06-f55e493bf789)


# I. home and intro
# 1. ContentView
The main interface's chapter selection pays homage to the iPod's cover flow page, mimicking the album selection design.  In this code, I added the rotation3DEffect function to achieve the effect. Each level resembles an album, displaying the chapter number, title, and simple drawing image.
![image](https://github.com/user-attachments/assets/a2c0e513-b54d-437a-879d-3ad73c06db00)
# 2. Chapter 1: intro - >ᴗ<✧
Integrate INTRODUCTION into the first level by introducing Boolean operations and allowing users to experience the interaction for themselves before attempting to complete the first level. At the same time, the shape of the puzzle to be completed in the first level is also the logo of the app.
![image](https://github.com/user-attachments/assets/a95389bf-c54c-421c-a982-76168e2e8fcd)

# II. Chapter level design
A total of nine chapters have been designed, of which Chapter 1 to Chapter 4 are two-piece puzzles and Chapter 5 to Chapter 9 are three-piece puzzles. Need to establish a grid and let the puzzle within the limit, the target shape of the picture, in the upper navigation bar on the left and right side of the “main page” and “answer” two buttons were added. After the success of an animation, the pop-up menu bar has a smooth animation effect.
# 1. page setup
First of all, the top shows the chapter number, the left side of the main menu button, the right side of the answer button. After clicking the answer button, it will show the hint picture with graphic outline. Next is the destination graphic image, 9*9 size grid. There is an area under the grid to show the success animation
# 2. The design of the jigsaw puzzle and the realization of the intersection
# (1) Two pieces of jigsaw puzzle
Chapter 1, for example, the need to create two pieces of the puzzle for the side lengths were 5 and 4 of the size of the two squares. The intersection of the two graphics is calculated using .path to determine the path of the graphics, and then use the intersection function to determine the intersection:
```
func intersection(
    _ other: Path,
    eoFill: Bool = false
) -> Path
```
![image](https://github.com/user-attachments/assets/52a7e931-3fc3-43c8-ae27-85364b477e6a)
# (2) Three-Piece Puzzle
The structure is similar to the code of the two-piece puzzle, but to add the implementation of the intersection of the three graphs. Take Chapter 5 as an example, you need to create a rectangle and two right triangles, where the intersection of the three shapes is used by splitting the shapes for sampling, and then determining whether the sampling points are within the intersection:
```
if pathT1.contains(point) && pathT2.contains(point) && pathR.contains(point) {
    // 如果该点在三个形状交集中，就把该小区域加入路径
    p.addRect(CGRect(x: x - deltaX/2,
    y: y - deltaY/2,
    width: deltaX,
    height: deltaY))
}
```
![image](https://github.com/user-attachments/assets/52ddb8c6-4039-4be9-85a8-c01cf88c6397)
# 3. Animations
An animation is created after each successful level, starting with a gray circle superimposed on a blue circle with a slightly smaller radius, the blue circle has a tick animation. The blue circle has a tick animation. After the tick animation, the blue circle's position and state remain unchanged, and the gray circle expands into a capsule and displays three icons for the following functions: main page, restart, and next chapter. So the final effect is a capsule, the blue circle is on the left side of the capsule (and the left side of the capsule is as wide as the round edge), the blue circle inside the capsule on the right side of the three buttons. Add the sound effect of successful App Store payment while the animation pops up.
![image](https://github.com/user-attachments/assets/36b6b563-c6db-440d-a3cd-538589303cac)
After completing the fifth chapter, an additional encouraging animation pops up.
![image](https://github.com/user-attachments/assets/7f77cf7b-03ea-4084-8a8c-2e98b9236d77)

# III. User Experience
This is a puzzle game for children, and I intend to create a page that will entice children to play so they can practice their spatial creativity and logical reasoning skills while enjoying the engaging game process. On this basis, I'm searching for a comfortable page design and fluid animation effects to provide a nice user experience.
I made the design as child-friendly as feasible. Children are naturally curious about everything, therefore to keep them focused on the experience, I chose to keep the game interface as simple as possible, offering as little information as possible to avoid distraction and to exercise their concentration. At the same time, I am a handbook diary enthusiast, so I decided to use my expertise in combining cute simple drawings to entice children to play the game and enhance their feeling of experience. Finally, because children's eyes are growing, I chose an eye-friendly macaroon shade of blue to create a cozy image.
As a minimalist and perfectionist, I've matched my design thinking with Apple's concepts and learned the fundamentals of app development. I chose a minimalist style with this app to accomplish "less is more" and keep the interface consistent. To make the game experience more comfortable and natural, I used as many fluent animations as feasible. In addition, I used my strengths and combined them with Apple's design, resulting in components of my simple drawing that were seamlessly integrated into Apple's design.
To summarize, this is a visually appealing and child-friendly game, and it was a delight to put my ideas into action in Swift. I am fond of the Swift Playground and have recommended it to many parents for their children to use. It's a software that allows kids to learn while having fun, which has huge implications for children's education and is one of the reasons I created Binary Jigsaw in the first place.
