```
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
```
