import SwiftUI
import AVFoundation





// 30x15网格视图
struct GridView0: View {
    let spacing: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0..<31, id: \.self) { x in
                ForEach(0..<16, id: \.self) { y in
                    Circle()
                        .fill(Color.gray.opacity(0))
                        .frame(width: 5, height: 5)
                        .position(
                            x: CGFloat(x) * spacing,
                            y: CGFloat(y) * spacing
                        )
                }
            }
        }
        .frame(width: 30 * spacing, height: 15 * spacing)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .inset(by: -2.5) 
                .stroke(Color.gray.opacity(0), lineWidth: 5)
        )
    }
}

// 圆形形状定义
// 直径 = 4.25 * spacing
struct CircleShapeL0: Shape {
    let position: CGPoint
    let spacing: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let diameter = 4.25 * spacing
            let radius = diameter / 2
            let circleRect = CGRect(
                x: position.x - radius,
                y: position.y - radius,
                width: diameter,
                height: diameter
            )
            path.addEllipse(in: circleRect)
        }
    }
}

// 直径 = 4 * spacing
struct CircleShapeS0: Shape {
    let position: CGPoint
    let spacing: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let diameter = 4 * spacing
            let radius = diameter / 2
            let circleRect = CGRect(
                x: position.x - radius,
                y: position.y - radius,
                width: diameter,
                height: diameter
            )
            path.addEllipse(in: circleRect)
        }
    }
}

// 可拖动圆形组件
struct DraggableCircleL0: View {
    @Binding var position: CGPoint
    let spacing: CGFloat
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        CircleShapeL0(position: position, spacing: spacing)
            .fill(Color.blue.opacity(0.25))
            .stroke(Color.blue, lineWidth: 1.25)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if dragOffset == .zero {
                    let touchLocation = value.location
                    dragOffset = CGSize(
                        width: touchLocation.x - position.x,
                        height: touchLocation.y - position.y
                    )
                }
                
                let newX = value.location.x - dragOffset.width
                let newY = value.location.y - dragOffset.height
                
                let (minX, maxX, minY, maxY) = boundaryValues()
                
                position = CGPoint(
                    x: max(minX, min(newX, maxX)),
                    y: max(minY, min(newY, maxY))
                )
            }
            .onEnded { _ in
                let (minX, maxX, minY, maxY) = boundaryValues()
                
                withAnimation(.easeInOut) {
                    position = CGPoint(
                        x: max(minX, min(position.x, maxX)),
                        y: max(minY, min(position.y, maxY))
                    )
                }
                dragOffset = .zero
            }
    }
    
    private func boundaryValues() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        let minX: CGFloat = 0 * spacing
        let maxX: CGFloat = 30 * spacing
        let minY: CGFloat = 0 * spacing
        let maxY: CGFloat = 15 * spacing
        return (minX, maxX, minY, maxY)
    }
}

struct DraggableCircleS0: View {
    @Binding var position: CGPoint
    let spacing: CGFloat
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        CircleShapeS0(position: position, spacing: spacing)
            .fill(Color.blue.opacity(0.25))
            .stroke(Color.blue, lineWidth: 1.25)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if dragOffset == .zero {
                    let touchLocation = value.location
                    dragOffset = CGSize(
                        width: touchLocation.x - position.x,
                        height: touchLocation.y - position.y
                    )
                }
                
                let newX = value.location.x - dragOffset.width
                let newY = value.location.y - dragOffset.height
                
                let (minX, maxX, minY, maxY) = boundaryValues()
                
                position = CGPoint(
                    x: max(minX, min(newX, maxX)),
                    y: max(minY, min(newY, maxY))
                )
            }
            .onEnded { _ in
                let (minX, maxX, minY, maxY) = boundaryValues()
                
                withAnimation(.easeInOut) {
                    position = CGPoint(
                        x: max(minX, min(position.x, maxX)),
                        y: max(minY, min(position.y, maxY))
                    )
                }
                dragOffset = .zero
            }
    }
    
    private func boundaryValues() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        let minX: CGFloat = 0 * spacing
        let maxX: CGFloat = 30 * spacing
        let minY: CGFloat = 0 * spacing
        let maxY: CGFloat = 15 * spacing
        return (minX, maxX, minY, maxY)
    }
}





// 精确交集形状计算
struct IntersectionShape01: Shape {
    let circle1: CircleShapeS0
    let circle2: CircleShapeS0
    
    func path(in rect: CGRect) -> Path {
        circle1.path(in: rect).intersection(circle2.path(in: rect))
    }
}

struct IntersectionShape02: Shape {
    let circle1: CircleShapeL0
    let circle2: CircleShapeS0
    
    func path(in rect: CGRect) -> Path {
        circle1.path(in: rect).intersection(circle2.path(in: rect))
    }
}










struct Chapter1: View {
    // 状态管理
    @StateObject private var successState = SuccessState()
    @State private var showElements = true // 控制初始元素显示
    @State private var showSecondState = false // 控制第二状态显示
    @State private var showSecondText = true // 控制"NAND"状态显示
    @State private var nandPosition = CGPoint(x: 22 * 40, y: 7 * 40) // 初始位置设置
    @State private var dragCirclePos = CGPoint(x: 15.75 * 40, y: 4 * 40) // 可拖动圆位置
    @State private var showFirstButton = true
    @State private var showSecondButton = false
    
    // 基础圆的位置状态
    @State private var circlePos01 = CGPoint(x: 7 * 40, y: 4 * 40)
    @State private var circlePos02 = CGPoint(x: 9 * 40, y: 4 * 40)
    @State private var circlePos03 = CGPoint(x: 14 * 40, y: 4 * 40)
    @State private var circlePos04 = CGPoint(x: 16 * 40, y: 4 * 40)
    @State private var circlePos05 = CGPoint(x: 21 * 40, y: 4 * 40)
    @State private var circlePos06 = CGPoint(x: 23 * 40, y: 4 * 40)
    let spacing: CGFloat = 40
    
    // 增加圆与图片交互判断
    private var isImageChecked: Bool {
        let yCorrect = (6  * spacing - dragCirclePos.y) < 1
        let xCorrect = (dragCirclePos.x - 12 * spacing) < 1
        return yCorrect && xCorrect
    }
    
    var body: some View {
        VStack {
            // 顶部导航栏
            HStack {
                Button(action: goToMenu) {
                    Image(systemName: "house")
                        .font(.system(size: 30))
                        .foregroundColor(.blue.opacity(0.75))
                        .frame(width: 50, height: 50)
                        .offset(x: 10)
                }
                Spacer()
            }
            .padding(.top, -100)
            
            Spacer().frame(height: UIScreen.main.bounds.height / 25)
            
            ZStack {
                // 网格视图
                GridView0(spacing: spacing)
                
                // MARK: - 初始状态元素
                if showElements {
                    Group {
                        // 原始六个圆
                        createCircle(position: circlePos01, fillOpacity: 0)
                        createCircle(position: circlePos02, fillOpacity: 0)
                        createCircle(position: circlePos03, fillOpacity: 0.25)
                        createCircle(position: circlePos04, fillOpacity: 0.25)
                        createCircle(position: circlePos05, fillOpacity: 0.25)
                        createCircle(position: circlePos06, fillOpacity: 0.25)
                        
                        // 交集区域
                        IntersectionShape01(
                            circle1: CircleShapeS0(position: circlePos01, spacing: spacing),
                            circle2: CircleShapeS0(position: circlePos02, spacing: spacing)
                        )
                        .fill(Color.blue.opacity(0.25))
                        
                        IntersectionShape01(
                            circle1: CircleShapeS0(position: circlePos03, spacing: spacing),
                            circle2: CircleShapeS0(position: circlePos04, spacing: spacing)
                        )
                        .fill(Color.white.opacity(0.375))
                        
                        IntersectionShape01(
                            circle1: CircleShapeS0(position: circlePos05, spacing: spacing),
                            circle2: CircleShapeS0(position: circlePos06, spacing: spacing)
                        )
                        .fill(Color.white)
                    }
                    .transition(.opacity) // 淡出过渡效果
                    
                    Image("image1View")
                        .resizable()
                        .scaledToFit()
                        .position(x: -6 * 40, y: 8 * 40)
                        .frame(width: 350, height: 350)
                }
                
                // MARK: - 第二状态元素
                if showSecondState {
                    Group {
                        // 为避免图片盖住圆导致无法拖动，放置在最底层
                        if isImageChecked {
                            Image("image1View2")
                                .resizable()
                                .scaledToFit()
                                .position(x: -6 * 40, y: 8 * 40)
                                .frame(width: 350, height: 350)
                        } else {
                            Image("image1View")
                                .resizable()
                                .scaledToFit()
                                .position(x: -6 * 40, y: 8 * 40)
                                .frame(width: 350, height: 350)
                        }
                        
                        // 固定圆和可拖动圆
                        CircleShapeS0(position: CGPoint(x: 13.75 * 40, y: 4 * 40), spacing: spacing)
                            .fill(Color.blue.opacity(0.25))
                            .stroke(Color.blue, lineWidth: 1.25)
                        
                        DraggableCircleL0(position: $dragCirclePos, spacing: spacing)
                        
                        IntersectionShape02(
                            circle1: CircleShapeL0(position: dragCirclePos, spacing: spacing),
                            circle2: CircleShapeS0(position: CGPoint(x: 13.75 * 40, y: 4 * 40), spacing: spacing)
                        )
                        .fill(Color.white)
                        
                        Text("Try dragging \n this circle.")
                            .font(.system(size: 24, design: .rounded))
                            .foregroundColor(.blue.opacity(0.875))
                            .position(CGPoint(x: 21.25 * 40, y: 4 * 40))
                            .transition(.opacity)
                        
                        // 第二页上方提示文字
                        Text("←")
                            .font(.system(size: 48, design: .rounded))
                            .foregroundColor(.blue.opacity(0.875))
                            .position(CGPoint(x: 19 * 40, y: 4 * 40))
                            .transition(.opacity)
                        
                        Text("The two pieces can interact with \n each other, like a binary system, \n      just like our jigsaw puzzle.")
                            .font(.system(size: 24, design: .rounded))
                            .foregroundColor(.blue.opacity(0.875))
                            .position(CGPoint(x: 15 * 40, y: 9 * 40))
                            .transition(.opacity)
                        
                        // 第二页下方提示文字
                        Text("←")
                            .font(.system(size: 48, design: .rounded))
                            .foregroundColor(.blue.opacity(0.875))
                            .position(CGPoint(x: 8 * 40, y: 12 * 40))
                            .transition(.opacity)
                        
                        Text("Can I touch the circle?")
                            .font(.system(size: 24, design: .rounded))
                            .foregroundColor(.blue.opacity(0.875))
                            .position(CGPoint(x: 11.5 * 40, y: 12 * 40))
                            .transition(.opacity)
                        
                        
                    }
                }
                
                // MARK: - 文字元素
                // AND文字
                Text("AND")
                    .font(.system(size: 36, design: .rounded))
                    .foregroundColor(.blue.opacity(0.875))
                    .position(CGPoint(x: 8 * 40, y: 7 * 40))
                    .opacity(showElements ? 1 : 0)
                
                // OR文字
                Text("OR")
                    .font(.system(size: 36, design: .rounded))
                    .foregroundColor(.blue.opacity(0.875))
                    .position(CGPoint(x: 15 * 40, y: 7 * 40))
                    .opacity(showElements ? 1 : 0)
                
                // NAND文字
                if showSecondText {
                    Text("NAND")
                        .font(.system(size: 36, design: .rounded))
                        .foregroundColor(.blue.opacity(0.875))
                        .position(nandPosition)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing), // 从右侧进入
                            removal: .move(edge: .leading)     // 向左侧退出
                        ))
                        .animation(.easeInOut(duration: 10), value: CGPoint(x: 15 * 40, y: 7 * 40))
                }
                
                // 说明文字
                Text(showSecondState ? "" : "Hello, and thank you for joining us! \n Let's explore Boolean operation.")
                    .font(.system(size: 24, design: .rounded))
                    .foregroundColor(.blue.opacity(0.875))
                    .position(x: 15 * 40, y: 9 * 40)
                    .transition(.opacity)
            }
            .frame(width: 30 * spacing, height: 9 * spacing)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Intro")
                        .font(.system(size: 24, design: .rounded))  // 自定义字体
                        .foregroundColor(.black)  // 可选择其他颜色
                }
            }
            
            ZStack {
                // 第一个状态按钮
                if showFirstButton {
                    Button(action: toggleStates) {
                        Image(systemName: "arrow.right.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.blue.opacity(0.75))
                            .frame(width: 50, height: 50)
                    }
                    .transition(.opacity)
                }
                
                // 第二个状态按钮（导航按钮）
                if showSecondButton {
                    NavigationLink(destination: Chapter1View()) {
                        Image(systemName: "arrow.right.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.blue.opacity(0.75))
                            .frame(width: 50, height: 50)
                    }
                    .transition(.opacity)
                }
            }
        }
    }
    
    // 创建圆形元素的辅助方法
    private func createCircle(position: CGPoint, fillOpacity: Double) -> some View {
        CircleShapeS0(position: position, spacing: spacing)
            .fill(Color.blue.opacity(fillOpacity))
            .stroke(Color.blue.opacity(0.75), lineWidth: 1.25)
    }
    
    // MARK: - 按钮点击处理方法
    private func toggleStates() {
        withAnimation {
            // 隐藏第一个按钮，显示第二个按钮
            showFirstButton = false
            showSecondButton = true
            
            // 原有状态切换逻辑保持不变
            showElements = false
            nandPosition = CGPoint(x: 15 * 40, y: 7 * 40)
            showSecondState = true
        }
    }
    
    private func goToMenu() {
        // 保存当前章节到UserDefaults
        UserDefaults.standard.set(0, forKey: "targetChapter")
        
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        window.rootViewController = UIHostingController(rootView: ContentView())
        window.makeKeyAndVisible()
    }
    
}

struct Chapter1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Chapter1()
        }
    }
}
