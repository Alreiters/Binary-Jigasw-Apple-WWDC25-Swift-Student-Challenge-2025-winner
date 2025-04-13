import SwiftUI
import AVFoundation





// 三角形形状定义
struct TriangleShape5: Shape {
    enum Direction {
        case leftShape      // 直角点在斜边左方
        case rightShape     // 直角点在斜边右方
    }
    
    let position: CGPoint
    let spacing: CGFloat
    let direction: Direction
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: position)
            switch direction {
            case .leftShape:
                path.addLine(to: CGPoint(x: position.x + 2 * spacing, y: position.y + 2 * spacing))
                path.addLine(to: CGPoint(x: position.x + 2 * spacing, y: position.y - 2 * spacing))
            case .rightShape:
                path.addLine(to: CGPoint(x: position.x - 2 * spacing, y: position.y + 2 * spacing))
                path.addLine(to: CGPoint(x: position.x - 2 * spacing, y: position.y - 2 * spacing))
                
            }
            path.closeSubpath()
        }
    }
}

// 可拖动三角形组件
struct DraggableTriangle5: View {
    @Binding var position: CGPoint
    let spacing: CGFloat
    let direction: TriangleShape5.Direction
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        TriangleShape5(position: position, spacing: spacing, direction: direction)
            .fill(Color.blue.opacity(0.75))
            .stroke(Color.blue, lineWidth: 0)
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
                let snappedX = (position.x / spacing).rounded() * spacing
                let snappedY = (position.y / spacing).rounded() * spacing
                
                let (minX, maxX, minY, maxY) = boundaryValues()
                
                withAnimation(.easeInOut) {
                    position = CGPoint(
                        x: max(minX, min(snappedX, maxX)),
                        y: max(minY, min(snappedY, maxY))
                    )
                }
                dragOffset = .zero
            }
    }
    
    private func boundaryValues() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        switch direction {
        case .leftShape: return (0, 7 * spacing, 2 * spacing, 7 * spacing)
        case .rightShape: return (2 * spacing, 9 * spacing, 2 * spacing, 7 * spacing)
        }
    }
}

// 长方形形状定义
struct RectangleShape5: Shape {
    let position: CGPoint
    let spacing: CGFloat 
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: position)
            path.addLine(to: CGPoint(x: position.x + 3 * spacing, y: position.y))
            path.addLine(to: CGPoint(x: position.x + 3 * spacing, y: position.y + 6 * spacing))
            path.addLine(to: CGPoint(x: position.x, y: position.y + 6 * spacing))
            path.closeSubpath()
        }
    }
}

// 可拖动长方形组件
struct DraggableRectangle5: View {
    @Binding var position: CGPoint
    let spacing: CGFloat
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        RectangleShape5(position: position, spacing: spacing)
            .fill(Color.blue.opacity(0.75))
            .stroke(Color.blue, lineWidth: 0)
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
                let snappedX = (position.x / spacing).rounded() * spacing
                let snappedY = (position.y / spacing).rounded() * spacing
                
                let (minX, maxX, minY, maxY) = boundaryValues()
                
                withAnimation(.easeInOut) {
                    position = CGPoint(
                        x: max(minX, min(snappedX, maxX)),
                        y: max(minY, min(snappedY, maxY))
                    )
                }
                dragOffset = .zero
            }
    }
    // 边界计算（示例值，可根据需求调整）
    private func boundaryValues() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        let minX: CGFloat = 0
        let maxX: CGFloat = 6 * spacing  
        let minY: CGFloat = 0
        let maxY: CGFloat = 3 * spacing  
        return (minX, maxX, minY, maxY)
    }
}





// 精确交集形状计算
struct IntersectionShape51: Shape {
    let triangle1: TriangleShape5
    let triangle2: TriangleShape5
    
    func path(in rect: CGRect) -> Path {
        triangle1.path(in: rect).intersection(triangle2.path(in: rect))
    }
}

struct IntersectionShape52: Shape {
    let triangle1: TriangleShape5
    let rectangle: RectangleShape5
    
    func path(in rect: CGRect) -> Path {
        triangle1.path(in: rect).intersection(rectangle.path(in: rect))
    }
}

struct IntersectionShape53: Shape {
    let triangle2: TriangleShape5
    let rectangle: RectangleShape5
    
    func path(in rect: CGRect) -> Path {
        triangle2.path(in: rect).intersection(rectangle.path(in: rect))
    }
}

struct IntersectionShape54: Shape {
    let triangle1: TriangleShape5
    let triangle2: TriangleShape5
    let rectangle: RectangleShape5
    
    func path(in rect: CGRect) -> Path {
        let sampleCount = 400
        var p = Path()
        
        let deltaX = rect.width / CGFloat(sampleCount)
        let deltaY = rect.height / CGFloat(sampleCount)
        
        let pathT1 = triangle1.path(in: rect)
        let pathT2 = triangle2.path(in: rect)
        let pathR = rectangle.path(in: rect)
        
        for i in 0..<sampleCount {
            for j in 0..<sampleCount {
                let x = rect.minX + (CGFloat(i) + 0.5) * deltaX
                let y = rect.minY + (CGFloat(j) + 0.5) * deltaY
                let point = CGPoint(x: x, y: y)
                
                // 判断该点是否在三个形状的交集范围内
                if pathT1.contains(point) && pathT2.contains(point) && pathR.contains(point) {
                    // 如果该点在三个形状交集中，就把该小区域加入路径
                    p.addRect(CGRect(x: x - deltaX/2,
                                     y: y - deltaY/2,
                                     width: deltaX,
                                     height: deltaY))
                }
            }
        }
        return p
    }
}










struct Chapter5: View {
    @StateObject private var successState = SuccessState()
    @State private var leftPos5 = CGPoint(x: 0 * 40, y: 3 * 40)
    @State private var rightPos5 = CGPoint(x: 9 * 40, y: 6 * 40)
    @State private var rectanglePos5 = CGPoint(x: 3 * 40, y: 2 * 40)
    @State private var showAnswer = false
    let spacing: CGFloat = 40
    
    private var isLevelCompleted: Bool {
        let baseFormed = abs(rightPos5.x - leftPos5.x - 1 * spacing) < 1.5 
        && abs(leftPos5.y - rightPos5.y) < 1.5
        
        let rectanglePositioned = abs(rectanglePos5.x - leftPos5.x + 1 * spacing) < 1.5 
        && abs(rectanglePos5.y - leftPos5.y + 3 * spacing) < 1.5
        
        return baseFormed && rectanglePositioned
    }
    
    var body: some View {
        VStack {
            
            HStack{
                Button(action: goToMenu) {
                    Image(systemName: "house")
                        .font(.system(size: 30))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/.opacity(0.75))
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.white))
                        .offset(x: 15)
                }
                
                Spacer()
                
                // 右侧按钮
                Button(action: { showAnswer.toggle() }) {
                    Image(systemName: "lightbulb.max")
                        .font(.system(size: 30))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/.opacity(0.75))
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.white))
                        .offset(x: -15)
                } 
            }            
            
            Image("Chapter5")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 10)
                .clipped()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 2.5)
                        .stroke(Color.gray.opacity(0.25), lineWidth: 3)
                )
            
            Spacer().frame(height: UIScreen.main.bounds.height / 20)
            
            ZStack {
                
                GridView(spacing: spacing)
                
                // 原始图形
                DraggableTriangle5(position: $leftPos5, spacing: spacing, direction: .leftShape)
                DraggableTriangle5(position: $rightPos5, spacing: spacing, direction: .rightShape)
                DraggableRectangle5(position: $rectanglePos5, spacing: spacing)
                
                IntersectionShape51(
                    triangle1: TriangleShape5(position: leftPos5, spacing: spacing, direction: .leftShape),
                    triangle2: TriangleShape5(position: rightPos5, spacing: spacing, direction: .rightShape)
                )
                .fill(Color.white)
                
                IntersectionShape52(
                    triangle1: TriangleShape5(position: leftPos5, spacing: spacing, direction: .leftShape),
                    rectangle: RectangleShape5(position: rectanglePos5, spacing: spacing)
                )
                .fill(Color.white)
                
                IntersectionShape53(
                    triangle2: TriangleShape5(position: rightPos5, spacing: spacing, direction: .rightShape),
                    rectangle: RectangleShape5(position: rectanglePos5, spacing: spacing)
                )
                .fill(Color.white)
                
                IntersectionShape54(
                    triangle1: TriangleShape5(position: leftPos5, spacing: spacing, direction: .leftShape),
                    triangle2: TriangleShape5(position: rightPos5, spacing: spacing, direction: .rightShape),
                    rectangle: RectangleShape5(position: rectanglePos5, spacing: spacing)
                )
                .fill(Color.blue.opacity(0.75))
                
                // 成功动画容器
                if successState.showSuccess {
                    successAnimationView
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(width: 9 * spacing, height: 9 * spacing)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Chapter 5")
                        .font(.system(size: 24, design: .rounded))  // 自定义字体
                        .foregroundColor(.black)  // 可选择其他颜色
                }
            }
            .onChange(of: [leftPos5.x, leftPos5.y, rightPos5.x, rightPos5.y, rectanglePos5.x, rectanglePos5.y]) { 
                checkCompletion()
            }
            // 添加答案显示层
            .overlay {
                if showAnswer {
                    Color.black.opacity(0.75)
                        .ignoresSafeArea()
                        .onTapGesture { showAnswer = false }
                    
                    Image("Chapter5Key") // 确保项目中有这个图片资源
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.25)
                }
            }
            
        }
        
        Spacer().frame(height: UIScreen.main.bounds.height / 5)
        
    }
    
    private var successAnimationView: some View {
        ZStack(alignment: .leading) {
            // 背景胶囊
            Capsule()
                .fill(Color.gray.opacity(0.125))
                .frame(
                    width: 60 + 175 * successState.capsuleProgress,
                    height: 60
                )
                .overlay(
                    Capsule()
                        .stroke(Color.gray.opacity(0.125), lineWidth: 0.25)
                )
            
            // 蓝色圆形基底
            Circle()
                .fill(Color.blue.opacity(0.75))
                .frame(width: 50, height: 50)
                .overlay(
                    CheckmarkShape(progress: successState.checkmarkProgress)
                        .stroke(Color.white, lineWidth: 3)
                        .padding(7.5)
                )
                .offset(x: 5 * successState.checkmarkProgress)
            
            // 功能按钮组
            HStack(spacing: 17.5) {
                ForEach(0..<3, id: \.self) { index in
                    optionButton(for: index)
                        .scaleEffect(successState.buttonAppearProgress[index])
                }
            }
            .padding(.leading, 70)
            .padding(.trailing, 20)
        }
        .overlay(
            Image("Chapter5Congratulations")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 500)
                .frame(height: 500)
                .scaleEffect(successState.keyImageScale)
                .opacity(successState.keyImageOpacity)
                .offset(y: -250) // 图片显示在顶部
                .animation(
                    .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 1),
                    value: successState.keyImageScale
                )
        )
        .compositingGroup()
        .padding(.horizontal, 20)
        .offset(y: 250)
        .onAppear(perform: startSuccessAnimation)
    }
    
    private func optionButton(for index: Int) -> some View {
        Group {
            switch index {
            case 0:
                Button(action: goToMenu) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.gray.opacity(0.75))
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color.white))
                }
            case 1:
                Button(action: restart) {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.gray.opacity(0.75))
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color.white))
                }
                
            case 2:
                NavigationLink(destination: Chapter6().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.gray.opacity(0.75))
                        .frame(width: 45, height: 45)
                        .background(Circle().fill(Color.white))
                    
                }
            default:
                EmptyView()
            }
        }
        .foregroundColor(.white)
        .frame(width: 40, height: 40)
    }
    
    private func startSuccessAnimation() {
        SoundManager.shared.playSuccessSound()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
        // 打勾动画
        withAnimation(.easeInOut(duration: 0.8)) {
            successState.checkmarkProgress = 1
        }
        
        // 胶囊扩展动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                successState.capsuleProgress = 1
            }
        }
        
        // 按钮依次出现
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                successState.buttonAppearProgress[0] = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    successState.buttonAppearProgress[1] = 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    successState.buttonAppearProgress[2] = 1
                }
            }
        }
        
        // 在胶囊动画之后添加图片动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                successState.keyImageScale = 1
                successState.keyImageOpacity = 1
            }
        }
    }
    
    private func checkCompletion() {
        if isLevelCompleted && !successState.showSuccess {
            withAnimation(.spring()) {
                successState.showSuccess = true
            }
        } else if !isLevelCompleted && successState.showSuccess {
            resetSuccessState()
        }
    }
    
    private func resetSuccessState() {
        withAnimation(.easeOut) {
            successState.showSuccess = false
            successState.checkmarkProgress = 0
            successState.capsuleProgress = 0
            successState.buttonAppearProgress = [0, 0, 0]
            
            // 重置时恢复图片状态
            successState.keyImageScale = 0
            successState.keyImageOpacity = 0
        }
    }
    
    private func restart() {
        withAnimation {
            leftPos5 = CGPoint(x: 0 * spacing, y: 3 * spacing)
            rightPos5 = CGPoint(x: 9 * spacing, y: 6 * spacing)
            rectanglePos5 = CGPoint(x: 3 * spacing, y: 2 * spacing)
        }
        resetSuccessState()
    }
    
    private func goToMenu() {
        // 保存当前章节到UserDefaults
        UserDefaults.standard.set(4, forKey: "targetChapter")
        
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        window.rootViewController = UIHostingController(rootView: ContentView())
        window.makeKeyAndVisible()
    }
}





struct Chapter5_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Chapter5()
        }
    }
}
