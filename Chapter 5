```
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
```
