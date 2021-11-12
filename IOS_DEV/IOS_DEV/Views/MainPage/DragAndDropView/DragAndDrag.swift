//
//  AutoScroll.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/18.
//

import SwiftUI
import UIKit
import MobileCoreServices
import SDWebImageSwiftUI
import CoreHaptics

struct SeachItem : Identifiable,Hashable{
    let id :String = UUID().uuidString
    let itemName : String
}


struct DragAndDropMainView: View {
    @AppStorage("seachHistory") var history : [String] =  []
    
    @EnvironmentObject  var StateManager : SeachingViewStateManager
    @StateObject private var searchMV = SearchBarViewModel()
    @EnvironmentObject var previewModel : PreviewModel
//    @EnvironmentObject var dragSearchModel : DragSearchModel
    //    @StateObject var StateManager  = SeachingViewStateManager()
    //current view state
//    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @State private var selectedPhoto:UIImage? // it may remove and instead with custom view
//    @State private var isCameraDisplay : Bool = false
//    @State private var isShowActionSheet :Bool = false

    init(){
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        return
            ZStack(alignment:.bottom){
                NavigationView{
                    VStack(spacing:0){
                        //TODO -DONE
                        if self.StateManager.previewResult{
                            //Loading previeModel preview Data
                            //Toggle preview result state
                            NavigationLink(destination:  MovieDetailView(movieId:self.previewModel.previewData!.id, navBarHidden: .constant(true), isAction: .constant(false), isLoading: .constant(true)), isActive: self.$StateManager.previewResult){
                                EmptyView()
                                
                            }
                        }
                        
                        //TODO -DONE
                        if self.StateManager.previewMoreResult{
                            
                            NavigationLink(destination: MorePreviewResultView(isNavLink: true, backPageName: "Search", isActive: self.$StateManager.previewMoreResult), isActive: self.$StateManager.previewMoreResult){EmptyView()}
                            
                        }
                        
                        //TODO -Working in progress..
                        if self.StateManager.getSearchResult{
                            NavigationLink(destination: SearchResultView(movie: self.searchMV.searchResult), isActive: self.$StateManager.getSearchResult){EmptyView()}
       
                        }

//                        SearchingBar(isCameraDisplay: self.$isCameraDisplay)
                        SearchingBar()
                           
                        Divider()
                        
                        ZStack(alignment:.top){
                            SeachDragingView()
//                                .background(BlurView(sytle: .systemThickMaterialDark).edgesIgnoringSafeArea(.all))
                                .zIndex(0)
                            
                            //TODO - TestOnly
                            searchingField(history: self.history)
                                .padding(.top,5)
                                .background(Color.black.edgesIgnoringSafeArea(.all))
                                .opacity(self.StateManager.isSeaching && !self.StateManager.isEditing ? 1 : 0)
                                .zIndex(1)
                            searchingResultList()
                                .ignoresSafeArea()
                                .background(Color.black.edgesIgnoringSafeArea(.all))
                                .opacity(self.StateManager.isEditing ? 1 : 0)
                                .zIndex(2)
                        }

                    }
                    //                    .zIndex(0)
                    .edgesIgnoringSafeArea(.all)
//                    .fullScreenCover(isPresented: self.$isCameraDisplay){
//                        //show the phone or phone lib as sheet
//                        CameraView(closeCamera : self.$isCameraDisplay)
//                    }
                    .alert(isPresented: self.$StateManager.isRemove){
                        withAnimation(){
                            Alert(title: Text("刪除所有搜尋歷史"), message: Text("確定刪掉?"),
                                  primaryButton: .default(Text("取消")){
                                    self.StateManager.isFocuse = [false,true]
                                  },
                                  secondaryButton: .default(Text("刪除")){
                                    withAnimation{
                                        UserDefaults.standard.set([],forKey: "seachHistory")
                                        self.StateManager.isFocuse = [false,true]
                                    }
                                  })
                        }
                        
                    }
                    .navigationViewStyle(DoubleColumnNavigationViewStyle())
                    .navigationTitle(self.StateManager.previewResult ? "Search" : "")
                    .navigationBarTitle(self.StateManager.previewResult ? "Search" : "")
                    .navigationBarHidden(true)
                }
            }
            .environmentObject(searchMV)
    }
    
}

struct ResultCareVIew : View{
    let movie : Movie
    var body: some View{
        VStack(alignment:.center){
            WebImage(url: movie.posterURL)
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .frame(height:230)
                .cornerRadius(25)
            
            
            
            VStack(alignment:.center){
                Text(movie.title)
                    .bold()
                    .foregroundColor(.white)
            }
            .font(.system(size: 15))
            .frame(width:150,height:45,alignment: .center)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            
            HStack{
                HStack(spacing:0){
                    if self.movie.genres != nil{
                        ForEach(0..<self.movie.genres!.count){i in

                            Text(self.movie.genres![i].name)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(.horizontal,3)

                            if i != self.movie.genres!.count - 1{
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    else{
                        Text("n/a...")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .lineLimit(1)
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("DropBoxColor"), lineWidth: 1)
        )
        .background(Color("ResultCardBlack").cornerRadius(10).padding(3))
        .padding(5)
    }
}

struct SearchResult : View {
    let movies :[Movie]
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    let gridItem = Array(repeating: GridItem(.flexible(),spacing: 5.0), count: 2)
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){ //TODO - need to change to UIKit
            LazyVGrid(columns: gridItem){
                ForEach(movies,id:\.self){ info in
                    VStack{
                        Button(action:{
                            self.selectedID = info.id
                            self.isShowDetail.toggle()
                        }){
                            ResultCareVIew(movie: info)
                        }
                    }
                }
            }
//            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
    }
}

struct searchingResultList :View{
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    var body: some View{
        List(){
//            Button(action: {
//                self.StateManager.isSeaching.toggle()
//                self.StateManager.isFocuse = [false,false]
//                self.StateManager.isEditing.toggle()
//                withAnimation(.easeInOut(duration: 0.3)){
//                    self.StateManager.getSearchResult = true
//                }
//            }){
//                HStack(spacing:2){
//                    Text("Search:")
//                        .foregroundColor(.blue)
//                    Text(searchMV.searchingText)
//                        .foregroundColor(.white)
//                        .padding(.horizontal,5)
//                    Spacer()
//                }
//            }
            if self.searchMV.searchResult.count > 0{
                ForEach(self.searchMV.searchResult,id:\.id){ searchData in
                    Button(action: {
                        
                        self.searchMV.searchingText = searchData.title
                        self.StateManager.isSeaching.toggle()
                        self.StateManager.isFocuse = [false,false]
                        self.StateManager.isEditing.toggle()
                        withAnimation(.easeInOut(duration: 0.3)){
                            self.StateManager.getSearchResult = true
                        }
                    }){
                        HStack(spacing:0){
//                            Image(systemName: "film")
//                                .font(.body)
//                                .foregroundColor(.gray)
                            Text(searchData.title)
                                .font(.system(size: 14))
                                .bold()
                            
                            Spacer()
                            
//                            Image(systemName: "arrowshape.turn.up.forward")
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

//TODO - May Change
struct searchingField : View{
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    let gridItems = Array(repeating: GridItem(.flexible(),spacing: 0), count: 2)
    var history : [String]
    var body :some View{
        ScrollView(.vertical, showsIndicators: false){
            //before user typing seaching thing
            //show user seaching history and recommand keyword
//
//            if history.isEmpty{
//                VStack{
//                    Spacer()
//                    Text("More interesting thing...")
//                        .foregroundColor(Color("DarkMode"))
//                        .bold()
//                        .font(.title2)
//                    Spacer()
//                }
//                .frame(maxWidth:.infinity,maxHeight: .infinity)
//            }else{
            if !history.isEmpty{
                
                HStack{
                    Text("搜尋歷史")
                        .fontWeight(.bold)
                        .font(.footnote)
                    Spacer()
                    
                    Button(action:{
                        withAnimation(.easeInOut(duration: 0.3)){
                            self.StateManager.isRemove.toggle()
                            self.StateManager.isFocuse = [false,false]
                        }
                    }){
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.vertical,5)
                
                HistorList(history: self.history)
                    .padding(.bottom,5)
                
            }
            
            if !self.searchMV.hotSearchingDatas.isEmpty{
                Group{
                    HStack{
                        Text("熱搜")
                            .fontWeight(.bold)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    
                    LazyVGrid(columns: gridItems){
                        ForEach(0..<self.searchMV.hotSearchingDatas.count){ i in
                            SearchHotCard(rank: i+1,rankColor: i <= 3 ? .red : .white, hotData: HotTest[i])
        //                        .padding(.horizontal)
        //                        .padding(.vertical,5)

                        }
                    }
                }
               
            }
  
            Spacer()
        }
        
    }
}

struct HistorList : View{
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    var history :[String]
    var body: some View{

            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(self.history,id:\.self){key in
                        searchFieldButton(searchingText: key){
                            self.StateManager.isSeaching.toggle()
                            self.searchMV.searchingText = key
                            self.StateManager.isEditing = false
                            withAnimation(.easeOut(duration:0.7)){
                                self.StateManager.isFocuse = [false,false]
                                self.StateManager.getSearchResult = true
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }
}

struct HotItem : Identifiable {
    let id = UUID().uuidString
    let key : String
    let description : String
}

let HotTest : [HotItem] = [
    HotItem(key: "猛毒",
            description: "身為外星共生體的「猛毒」因需寄託宿主才能生存，找上記者艾迪布洛克（湯姆哈迪 飾）成為最新宿主，共生過程不僅賦與宿主超乎想像的強大能力，更將影響宿主的內心意識。誓言調查真相的記者艾迪布洛克該如何才能與毒共存、運用自己正邪交織的能力來以毒攻毒呢？"),
    HotItem(key: "尚氣與十環傳奇",
            description: "故事敘述尚氣（劉思慕飾演）自幼接受父親文武（梁朝偉飾演）的鐵血戰鬥培訓，精通各種武術招式。長大後為了逃離家鄉，他改名換姓展開新生活，認識了新摯友凱蒂（奧卡菲娜飾演），平靜日子就這樣過了十年，直到過去再度找上門… 尚氣能否會發掘十環的無敵力量，無懼擺脫父親的勢力？"),
    HotItem(key: "Simu Liu", description: "Simu Liu (born 19 April 1989) is a Canadian actor, writer, and stuntman. He is known for his performance as Jung Kim in the award-winning CBC Television sitcom Kim's Convenience. He received nominations at the ACTRA Awards and Canadian Screen Awards for his work in Blood and Water. He portrays Shang-Chi in the 2021 Marvel Cinematic Universe film Shang-Chi and the Legend of the Ten Rings."),
    HotItem(key: "Fala Chen", description: "Fala Chen, born 24 February 1982, is a Hong Kong actress previously under contract with TVB. She is a 2018 graduate of The Juilliard School. A former beauty pageant titleholder, Chen holds the titles of Miss Asian America 2002 and Miss NY Chinese 2004. She was placed as the 1st runner-up in Miss Chinatown USA 2003 and in Miss Chinese International 2005."),
    HotItem(key: "美國隊長", description: "在第二次世界大戰，忠貞愛國的史提芬羅傑斯想要加入軍隊，幫助美國打敗納粹德軍，可是他卻因為沒通過體檢而無法為國效命。就在一次因緣際會下，他參加了軍方的一個秘密實驗計畫...。史提芬接受改造後擁有了神力，之後他便身穿紅、白、藍三色戰鬥服為國家效力，成了人人尊稱的美國隊長。 美國隊長和其隊友在賈斯特菲力浦斯將軍（湯米李瓊斯飾）的領導下，向以紅骷髏（雨果威明飾）為首的納粹黨神秘科學組織九頭蛇軍團宣戰，一場正邪大戰就此展開！"),
    HotItem(key: "美國隊長2", description: "《美國隊長2：酷寒戰士》由《新婚奧客》導演安東尼羅索執導，克里斯伊凡、賽巴斯汀史坦領銜主演，故事接續在《復仇者聯盟》的外星人入侵紐約事件之後。 美國隊長史蒂夫羅傑斯（Steve Rogers）隱居在美國華盛頓特區，他努力適應現代世界，但在一名神盾局同僚遭受攻擊後，他被捲入一起讓世界瀕臨險境的陰謀之中。 史蒂夫羅傑斯與黑寡婦聯手出擊，他一方面釐清這起錯縱複雜的陰謀，一方面應付著打算致他於死地的專業殺手，就在揭開這起邪惡計畫的全貌後，他們獲得新戰友獵鷹的協助。但兩人隨即發現自己面對的是意料之外的難纏敵人 - 酷寒戰士。"),
    HotItem(key: "Scarlett Johansson", description: "史嘉蕾喬韓森七歲時看了茱蒂佛斯特的《沉默的羔羊》就迷上了表演，九歲開始參與電視演出，十歲即開始在電影中露臉。1998年她演出勞勃瑞福導演的《輕聲細語》，超齡的演出讓她受到許多影評人的矚目，也漸漸打開了知名度。2003年她接連演出兩部被受好評的電影《愛情不用翻譯》及《戴珍珠耳環的少女》，細膩的演技讓她獲得多項大獎提名，史嘉蕾也一躍成為前途最看好的新生代女星，許多大導演紛紛找上她合作。2005年她成為名導伍迪艾倫的新謬思女神，一連演出了三部他的作品《愛情決勝點》、《遇上塔羅牌情人》及《情遇巴塞隆納》，三種截然不同的形象都詮釋的絲絲入扣。2010年她也參與年度強片《鋼鐵人2》，首度飾演反派「黑寡婦」。"),
    HotItem(key: "Chris Evans", description: "於美國麻薩諸塞州波士頓出生，擁有義大利和愛爾蘭血統；克里斯擁有陽光般的笑容與健美的身材，帥氣形象深植人心。他的演藝生涯似乎與漫畫角色有很深的緣分，陸續演出了《敗者為王》的Jensen、《歪小子史考特》的Lucas Lee、2005年《驚奇4超人》的「霹靂火」(Johnny Storm)、與2011年《美國隊長》的「美國隊長」(Steve Rogers)；其中，又以後兩部電影的演出讓他在好萊塢闖出名號、而克里斯詮釋的美國隊長的形象：俊秀臉蛋、肌肉身材、剛毅正直的性格，更讓他大紅大紫。"),
    HotItem(key: "美國隊長3：英雄內戰", description: "接續電影《復仇者聯盟2：奧創紀元》的故事情節，在《美國隊長3：英雄內戰》中美國隊長繼續帶領著復仇者們保護世界的和平。然而在某次的任務中，意外造成無辜生命的犧牲，使得「美國隊長」(克里斯伊凡飾)和「鋼鐵人」(小勞勃道尼飾)對於超級英雄是否應該被政府管制的看法出現嚴重歧異，進而導致復仇者聯盟的分裂。 另一方面，「獵鷹」在尋找失蹤人口時，尋獲了「酷寒戰士」，並揭露他可能就是殺害「鋼鐵人」父母的元兇，使得局面陷入更複雜難解的狀態，而此時美國隊長的頭號宿敵「莫澤男爵」，卻再度現身攪局......"),
    HotItem(key: "Robert Downey Jr.", description: "小勞勃道尼生於紐約州，青少年時期曾參加表演藝術中心的課程，道尼隨後跟著導演間演員的父親在加州長大。二十歲後，他成為美國喜劇節目《週末夜現場》的固定班底，模仿過許多名人，如：貓王、喬治麥可、西恩潘和保羅賽門等。"),
    HotItem(key: "黑寡婦", description: "故事時間點設定在《美國隊長 3 : 英雄內戰》之後，娜塔莎因為幫助了美國隊長而踏上流亡之路，當她發現一個與過去有關的陰謀時，她必須全球追蹤，回頭面對她神祕的間諜生涯，同時逃過反派「模仿大師」的追殺。"),
    HotItem(key: "終極異噬界", description: "世界末日，大開殺戒。惡名昭彰的戰爭英雄福特上校（布魯斯威利飾演），帶領士兵對外星活屍展開攻擊，希望在星際大戰爆發之前，拯救這場地球危機。沒想到友軍卻慘遭俘虜，還成為活屍入侵媒介。就當雙方對峙、戰爭一觸即發之際，唯有挺身而出，才能拯救整個人類文明…"),
    HotItem(key: "復仇者聯盟：終局之戰", description: "接續《復仇者聯盟3：無限之戰》為復仇者聯盟系列最終章！薩諾斯彈指間毀滅宇宙一半的生物後，僅存的復仇者們要如何重整旗鼓，背水一戰，為僅存的信念而戰。"),
    HotItem(key: "復仇者聯盟", description: "邪惡勢力悄悄集結，力量已龐大到極為驚人的地步，危機已非任何英雄能獨力面對。為了保護地球的安危，神盾局(S.H.I.E.L.D)局長尼克福瑞(Samuel L. Jackson 飾)費盡心力將各方超級英雄聚集一堂，包括鋼鐵人、綠巨人浩克、雷神索爾、鷹眼與黑寡婦，還有剛從冰獄裡甦醒的美國隊長。 於是，「復仇者聯盟」就此組成，然而各自擁有強大神力或武器的超級英雄，必須能夠放下彼此之間的偏見，同心協力找到合作的模式，才有機會與邪惡勢力一博。而要阻止邪惡計畫的他們，團結的力量真能成功擊敗敵人？"),
    HotItem(key: "鋼鐵人", description: "身價億萬企業家，兼天才發明家的東尼史塔克（小勞勃道尼 飾），以身為美國政府頂尖武器承包商「史氏工業」的總裁，在幾十年間保護美國引以為傲，他的公司總是出品最先進，最高檔的武器，也因此在全球享有極高的聲望。 一次武器攻擊測試中，東尼與隊員竟然遭到暴徒挾持，他的隊員都因此而喪命，東尼則因受到砲彈碎片傷及心臟而生命垂危，不得已下，只好服從神秘暴徒首領雷薩（法倫泰賀 飾）之命，建造一具破壞性極大的毀滅武器。 東尼一方面為雷薩製造武器，一方面運用自己的聰明才智為打造出一套鋼鐵衣，幫助他維持生命，並逃出暴徒的魔掌。 經由這次的意外，東尼領悟到「史氏工業」所發明出的武器，製造了許多可怕的災難，回到美國後，他誓言帶領「史氏工業」邁向新的方向，將科技用來造福更多需要幫助的人們。 然而，他不在公司的期間，他的領導地位被他的左右手－最高執行長施奧比（傑夫布里吉 飾）頂替，他只好設法在施奧比的阻撓下，每天從早到晚埋頭待在自己的工廠開發更先進的鋼鐵衣，以求得超出人類的力量來保護自己的身體。 藉由長期助理小辣椒波茲（葛妮絲派特洛 飾）及值得信任的羅德上校（泰倫斯霍華 飾）鼎力相助，東尼揭發了一件全球性的恐怖破壞計劃。於是，他穿上賦予他強大力量的全新紅金色鋼鐵衣，宣示要保護這個世界不受邪惡勢力的威脅。")
]

struct SearchHotCard : View{
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    var rank : Int
    var rankColor : Color = .white
    var hotData : HotItem
    var body: some View{
        Button(action:{
            self.StateManager.isSeaching.toggle()
            self.searchMV.searchingText = hotData.key
            self.StateManager.isEditing = false
            withAnimation(.easeOut(duration:0.7)){
                self.StateManager.isFocuse = [false,false]
                self.StateManager.getSearchResult = true
            }
            
            self.searchMV.getRecommandationList(keyWork: hotData.key)
        }){
            VStack(alignment:.leading){
                HStack(spacing:15){
                    VStack  {
                        Spacer()
                        Text(rank.description)
                            .bold()
                            .font(.footnote)
                            .foregroundColor(rankColor)
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Text(hotData.key)
                            .bold()
                            .font(.footnote)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text(hotData.description)
                            .foregroundColor(.gray)
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
            }
            .padding(5)
        }
//        .frame(maxWidth:.infinity,maxHeight: .infinity)
    }
}

//TODO -NOT USED
struct HStackLayout: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    var list : [String]
    var body: some View {
        VStack{
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.list, id: \.self) { item in
                searchFieldButton(searchingText: item){
                    self.StateManager.isSeaching.toggle()
                    self.searchMV.searchingText = item
                    self.StateManager.isEditing = false
                    withAnimation(.easeOut(duration:0.7)){
                        self.StateManager.isFocuse = [false,false]
                        self.StateManager.getSearchResult = true
                    }
                }
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if item == self.list.last! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if item == self.list.last! {
                        height = 0 // last item
                    }
                    return result
                })
            }
        }
    }

}

struct searchFieldButton : View {
    var searchingText:String
    var action : ()->()
    var body: some View{
        return VStack{
            Button(action:action){
                Text(searchingText)
                    .font(.system(size: 15))
                    .foregroundColor(Color.white)
            }
            .frame(width:getStrWidth(searchingText),height:30)
            .padding(.horizontal,5)
            .background(BlurView())
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.45), radius: 10, x: 0, y: 0)
        }
    }

    func getStrWidth(_ str:String)->CGFloat{
        //get current string size
        return str.widthOfStr(Font: .systemFont(ofSize: 15,weight: .bold))
    }
}

struct SearchingMode: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    
    @State private var isDelete:Bool = false
    var body: some View {
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(.horizontal,8)
                
                UITextFieldView(keybooardType: .default, returnKeytype: .search, tag: 1)
                    .frame(height:22)
                
                if self.StateManager.isEditing {
                    Button(action:{
                        withAnimation{
                            self.searchMV.searchingText.removeAll()
                        }
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .padding(self.StateManager.isSeaching ? 2 : 0)
    }
}

struct SeachingButton: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
//    @Binding var isCameraDisplay : Bool
    var body: some View {
        HStack(spacing:0){
            Button(action:{
                self.StateManager.isFocuse = [false,true]
                //TO EXPAND THE SEACHING BAR
                self.StateManager.isSeaching.toggle()
                
            }){
                Image(systemName: "magnifyingglass")
                    .padding(10)
                    .foregroundColor(.white)
            }
            .background(Color("DropBoxColor").clipShape(CustomeConer(coners: [.topLeft,.bottomLeft,.topRight,.bottomRight])))

//            Button(action:{
//                withAnimation{
//                    //just toggle the camera viesw
//                    self.isCameraDisplay.toggle()
//                }
//            }){
//                Image(systemName: "camera")
//                    .padding(10)
//                    .foregroundColor(.white)
//            }
//            .background(Color("DropBoxColor").clipShape(CustomeConer(coners: [.topRight,.bottomRight])))
        }
    }
}

struct SearchingBar: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    
//    @Binding var isCameraDisplay :Bool
    var body: some View {
        HStack(spacing:0){
            if !self.StateManager.isSeaching {
                Text("Search")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                Spacer()
            }

            HStack{
                if self.StateManager.isSeaching {
                    HStack{
                        Button(action: {
                            self.StateManager.isSeaching.toggle()
                            withAnimation(.easeInOut){
                                self.searchMV.searchingText.removeAll() //for currrent view only
                                self.StateManager.isEditing = false
                                self.StateManager.isFocuse = [false,false]
                            }
                            
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 2)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                        
                        SearchingMode()
                    }
                }
                else {
//                    SeachingButton(isCameraDisplay: self.$isCameraDisplay)
                    SeachingButton()
                }
            }
            .padding(self.StateManager.isSeaching ? 2 : 0)
//            .cornerRadius(25)
        }
//        .padding(.top, 50 )
        .padding(.horizontal)
        .padding(.bottom,5)
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color("DarkMode2"))
    }
}

struct ResultList : View{
    var result : [Movie]
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    var body: some View{
        HStack{
            ForEach(self.result){ item in
                ResultCardView(isShowDetail: self.$isShowDetail, selectedID: self.$selectedID, movie: item)
            }
        }
    }
}

struct SearchResultView: View {
    @AppStorage("seachHistory") var history : [String] =  []
    
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    
    @State private var page = 1
//    @State private var showAsList : Bool = false
    
    @State private var isShowDetail : Bool = false
    @State private var selectedID : Int?
    var movie : [Movie]
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HStack{
                    Button(action: {
                        withAnimation(){
                            if !self.StateManager.isSeaching {
                                self.StateManager.getSearchResult = false
                                self.searchMV.searchingText.removeAll()
                            }
                            
                            if !self.StateManager.isEditing{
                                self.StateManager.getSearchResult = false
                            }
                            
                            self.StateManager.isSeaching = false
                            self.StateManager.isEditing = false
                        }

                        
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 2)
                    
                    if !self.StateManager.isSeaching {
                        HStack{
                            HStack{
                                Text(self.searchMV.searchingText)
                                    .foregroundColor(.white)
                                    .padding(.leading,5)
                                    .lineLimit(1)
                                Spacer()
                            }
                            .frame(maxWidth:.infinity)
                            .background(Color.black.opacity(0.05))
                            .onTapGesture {
                                self.StateManager.isFocuse = [false,true]
                                withAnimation(){
                                    self.StateManager.isSeaching = true
                                    self.StateManager.isEditing = false
                                }

                            }
                            Spacer()
                            Button(action:{
                                withAnimation(){
                                    //Clean the text and turn on the search mode
                                    //now is nothing to do
                                        self.StateManager.isSeaching = true
                                        self.searchMV.searchingText.removeAll()
                                        self.StateManager.isFocuse = [false,true]
                                    
                                }
                            }){
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,3)
                            }
//                            //A toggle button to toggle show tag a list or a silder
//                            Button(action:{
//                                withAnimation(){
//                                    self.showAsList.toggle()
//                                }
//                            }){
//                                Image(systemName: "list.and.film")
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal,3)
//                            }
                        }
                        .transition(.identity)
                        .padding(.vertical,5)
                    }else{
                        SearchingMode()
                            .padding(.vertical,5)
                    }
                    
                    
                }
                .padding(.horizontal,8)
                .padding(.vertical,5)
                .background(Color("DarkMode2").edgesIgnoringSafeArea(.all))
                
                Divider()
                ZStack(alignment:.top){
                    //show history view
                    searchingField(history: self.history)
                        .padding(.top,5)
                        .ignoresSafeArea()
                        .background(Color.black.edgesIgnoringSafeArea(.all))
                        .opacity(self.StateManager.isSeaching && !self.StateManager.isEditing ? 1 : 0)
                        .zIndex(1)
                    //                            .transition(.identity)
                    
                    //show seaching recommandation view
                    searchingResultList()
                        .ignoresSafeArea()
                        .background(Color.black.edgesIgnoringSafeArea(.all))
                        .opacity(self.StateManager.isEditing ? 1 : 0)
                        .zIndex(2)
                    
                    if self.StateManager.searchingLoading{
                        VStack{
                            Spacer()
                            HStack{
                                ActivityIndicatorView()
                                Text("Loading...")
                                    .bold()
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                                withAnimation(){
                                    self.StateManager.searchingLoading = false
                                }
                            }
                        }
                        
                    }else{
                        SearchResult(movies: movie, isShowDetail: self.$isShowDetail, selectedID: self.$selectedID)
//                        MovieSeachResultView(isShowDetail: self.$isShowDetail, selectedID: self.$selectedID, movie: movie)
//                            .opacity(self.showAsList == false ? 1 : 0)
                            .transition(.opacity)
                    }
                    //
//                    SearchResult(movies: movie, isShowDetail: self.$isShowDetail, selectedID: self.$selectedID)
////                    MovieResultList(movies: movie, isShowDetail: self.$isShowDetail, selectedID: self.$selectedID)
//
//                        .opacity(self.showAsList ? 1 : 0)
//                        .offset(x:self.showAsList ? 0 : -UIScreen.main.bounds.width)
//                        .zIndex(3)
//                        .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
//
                    //
                    
                }
            }
            .frame(maxWidth:.infinity,maxHeight:.infinity)
            .navigationTitle(self.isShowDetail ? "Search" : "")
            .navigationBarTitle(self.isShowDetail ? "Search" : "")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            if self.selectedID != nil{
                NavigationLink(destination:  MovieDetailView(movieId:self.selectedID!, navBarHidden: .constant(true), isAction: .constant(false), isLoading: .constant(true)) , isActive: self.$isShowDetail){
                    EmptyView()
                    
                }
            }
            
        }
        
    }
}

struct MovieResultList : View {
    let movies :[Movie]
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    var body: some View{
        List{
            ForEach(movies,id:\.self){ movie in
                Button(action:{
                    withAnimation(){
                        self.selectedID = movie.id
                        self.isShowDetail.toggle()
                    }
                }){
                    MovieResultListCell(movie: movie)
                }
            }
            
        }
        .listStyle(PlainListStyle())
    }
}

struct MovieResultListCell : View {
    let movie : Movie
    var body: some View{
        HStack(alignment:.top){
            WebImage(url: movie.posterURL)
                .resizable()
                .placeholder{
                    Text(movie.title)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .aspectRatio(contentMode: .fill)
                .frame(width:UIScreen.main.bounds.width / 3.5)
                .clipped()
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 6, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 1)
                )
                .cornerRadius(10)
            
            
            
            VStack(alignment:.leading,spacing:10){
                Text(movie.title)
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
                
                Text("Language: \(movie.originalLanguage)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                //Genre
                HStack(spacing:0){
                    Text("Genre: ")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    if self.movie.genres != nil{
                        HStack(spacing:0){
                            ForEach(0..<(movie.genres!.count >= 2 ? 2 : movie.genres!.count)){ i in
                                
                                Text(movie.genres![i].name)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                if i != (movie.genres!.count >= 2 ? 1 : movie.genres!.count - 1){
                                    Text(",")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .lineLimit(1)
                    }else{
                        Text("n/a")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                
                //actor
                HStack(spacing:0){
                    //at most show 2 genre!
                    Text("Actor: ")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    if self.movie.cast != nil{
                        HStack(spacing:0){
                            ForEach(0..<(self.movie.cast!.count >= 2 ? 2 :  self.movie.cast!.count) ){ i in

                                Text(self.movie.cast![i].name)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)

                                if i != (movie.cast!.count >= 2 ? 1 : self.movie.cast!.count - 1){
                                    Text(",")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .lineLimit(1)
                    }else{
                        Text("n/a")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }

                }
//
                Text("Release: \(movie.releaseDate ?? "Coming soon...")")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                Text("Time: \(movie.durationText)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.top,5)
            
            Spacer()
        }

    }
}

struct MovieSeachResultView : View{
    @State private var page = 0
    
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    var movie : [Movie]
    var body : some View{
        return
            ZStack{
                TabView(selection:$page){
                    ForEach(movie.indices,id:\.self){ i in
                        GeometryReader{proxy in
                            WebImage(url:  movie[i].posterURL)
                                .resizable()
                                .aspectRatio(contentMode:.fill)
                                .frame(width:proxy.size.width,height:proxy.size.height)
                                .cornerRadius(1)
                        }
                        .offset(y:-100)
                    }

                }
                .edgesIgnoringSafeArea(.top)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.2),
                        Color.black.opacity(0.4),
                        Color.black,
                        Color.black,
                        Color.black,

                    ]), startPoint: .top, endPoint: .bottom)
                )
                
                GeometryReader{proxy in
                    UIHScrollList(width: proxy.frame(in: .global).width, hegiht: proxy.frame(in: .global).height, cardsCount: movie.count, page: self.$page){
                        ResultList(result: movie, isShowDetail: self.$isShowDetail, selectedID: self.$selectedID)
                    }
                }

            }
    }
}

struct ResultCardView: View{
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    let movie : Movie
    var body : some View{
        VStack{
            VStack(spacing:10){
                Text(movie.title)
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical,3)
                    .padding(.top,5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                
                //max 3 only
                if movie.genres != nil{
                    HStack(alignment:.center){
                        
                        ForEach(0..<(movie.genres!.count > 3 ? 3 : movie.genres!.count)){i in
                            Text(movie.genres![i].name)
                                .bold()
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal,3)
                            if i != (self.movie.genres!.count > 3 ? 2 : movie.genres!.count - 1){
                                Circle()
                                    .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.red)
                            }
                            
                        }
                    }
                    .padding(.bottom)
                }else{
                    HStack(alignment:.center){
                        Text("Genre:N/A")
                            .bold()
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal,3)
                    }
                    .padding(.bottom)
                    
                }
            
                
                WebImage(url: movie.posterURL)
                    .resizable()
                    .placeholder{
                        Text(movie.title)
                    }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .aspectRatio(contentMode: .fit)
                    .frame(width:UIScreen.main.bounds.width / 1.65)
                    .clipped()
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 6, y: 6)
                    .padding(.bottom)
                    
                
                
                HStack(alignment:.center){
                    VStack(alignment:.leading,spacing:3){
                        Text("RELEASE")
                        Text(movie.releaseDate ?? "Comming soon...")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 3){
                        Text("PLAY TIME")
                        Text(movie.durationText)
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                    
                }
                .foregroundColor(.gray)
                .font(.caption)
                .padding(.horizontal,30)
                
                VStack{
                    
                    HStack(){
                        
                        SmallRectButton(title: "Like", icon: "heart", textColor: .white){
                            
                        }
                        
                        Spacer()
                        
                        SmallRectButton(title: "Detail", icon: "ellipsis.circle",buttonColor: Color("BluttonBulue2")){
                            withAnimation(){
                                self.isShowDetail.toggle()
                                self.selectedID = movie.id
                            }
                        }
                       
                    }
                    .padding(.horizontal,20)
                }

                
            }
            .padding(.vertical,15)
            .background(BlurView().cornerRadius(20))
            .padding()
            
        }
        .padding(.horizontal,10)
        .padding(.leading,5)
    }
}

