import SwiftUI

struct ContentView: View {
    // 章节内容数组，每个元素包括章节标题、描述和图片名称
    let levels = [
        ("Chapter 1", "intro - >ᴗ<✧", "image1"),
        ("Chapter 2", "butterfly ~ ʚiɞ", "image2"),
        ("Chapter 3", "podium ! ✌︎︎•◡•𝕪𝕖𝕖𝕖𝕖", "image3"),
        ("Chapter 4", "Apple Park ! ! ! ", "image4"),
        ("Chapter 5", "hourglass...๑ᵒᯅᵒ๑", "image5"),
        ("Chapter 6", "I am Bat(man) ! 𓆩 - 𓆪", "image6"),
        ("Chapter 7", "Darth Vader ᗜ ‸ ᗜ", "image7"),
        ("Chapter 8", "Safari ? (Special Vresion)", "image8"),
        ("Chapter 9", "Swift ! ! ! ! ！", "image9"),
        ("Chapter 10", "To be continued......", "image10")
    ]
    
    @State private var scrollOffset: CGFloat = 0
    @State private var activePage: Int = UserDefaults.standard.integer(forKey: "targetChapter") // 读取存储的章节
    @State private var needsInitialScroll = true  // 新增状态控制初始滚动
    
    private let cardWidth: CGFloat = 400  // 卡片的宽度
    private let cardHeight: CGFloat = 325 // 卡片的高度
    private let spacing: CGFloat = 100    // 卡片之间的间距，已增加间距
    
    var body: some View {
        NavigationStack {
            // 获取屏幕宽度
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        HStack(spacing: spacing) {
                            ForEach(Array(levels.enumerated()), id: \.offset) { index, level in
                                // 修改 NavigationLink 为对应的章节视图
                                NavigationLink(destination: getChapterView(for: index).navigationBarBackButtonHidden(true)) {
                                    VStack {
                                        Text(level.0)
                                            .font(.system(size: 24, design: .rounded))
                                            .foregroundColor(.blue.opacity(0.75))
                                            .padding(.top, -30)
                                        
                                        Text(level.1)
                                            .font(.system(size: 36, design: .rounded))
                                            .foregroundColor(.blue.opacity(0.875))
                                            .padding(.top, -20)
                                        
                                        Image(level.2)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                            .padding(.top, -25)
                                    }
                                    .frame(width: cardWidth, height: cardHeight)
                                    .padding(25)
                                    .background(Color.cyan.opacity(0.0625))
                                    .cornerRadius(5)
                                    .padding(.bottom, 175)
                                    .padding(.top, geometry.size.height / 4)
                                    .rotation3DEffect(
                                        .degrees(Double(activePage - index) * 30),  // 增加旋转角度
                                        axis: (x: 0, y: 1, z: 0),
                                        anchor: .center,
                                        perspective: 2
                                    )
                                    .scaleEffect(activePage == index ? 1.5 : 0.75)
                                    .animation(.easeInOut(duration: 0.3), value: activePage)
                                }
                                .id(index)
                                .frame(width: cardWidth)
                            }
                        }
                        .padding(.horizontal, (screenWidth - cardWidth) / 2)
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ScrollOffsetKey.self, value: geo.frame(in: .named("scrollView")).minX)
                            }
                        )
                    }
                    .onAppear {
                        // 在视图出现时处理滚动
                        if needsInitialScroll {
                            proxy.scrollTo(activePage, anchor: .center)
                            needsInitialScroll = false
                        }
                    }
                    .coordinateSpace(name: "scrollView")
                    .onPreferenceChange(ScrollOffsetKey.self) { value in
                        scrollOffset = -value
                    }
                    .onChange(of: scrollOffset) {
                        let pageWidth = cardWidth + spacing
                        let currentPage = Int(round(scrollOffset / pageWidth))
                        
                        withAnimation {
                            activePage = min(max(currentPage, 0), levels.count - 1)
                        }
                    }
                    .onChange(of: activePage) { 
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(activePage, anchor: .center)
                        }
                    }
                }
            }
            .onAppear {
                // 检查是否有存储的章节
                if let savedChapter = UserDefaults.standard.object(forKey: "targetChapter") as? Int {
                    activePage = savedChapter
                    UserDefaults.standard.removeObject(forKey: "targetChapter")
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement:.principal) {
                    VStack {
                        Text("Binary Jigsaw")
                            .font(.system(size: 45, design: .rounded)).fontWeight(.medium)
                        Spacer(minLength: 5)
                        Text("Choose the album 'Chapter 1' to  start.")
                            .font(.system(size: 24, design: .rounded))
                    }
                    .padding(.top, 175)
                }
            }
        }
        .accentColor(.blue.opacity(0.75))
    }
    
    // 根据 index 返回对应的章节视图
    func getChapterView(for index: Int) -> some View {
        switch index {
        case 0: return Chapter1()
        case 1: return Chapter2()
        case 2: return Chapter3()
        case 3: return Chapter4()
        case 4: return Chapter5()
        case 5: return Chapter6()
        case 6: return Chapter7()
        case 7: return Chapter8()
        case 8: return Chapter9()
        case 9: return Chapter10()
        default: return Text("Chapter not found")
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
