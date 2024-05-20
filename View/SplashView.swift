import SwiftUI
import SDWebImageSwiftUI
struct SplashView: View {
    @State private var navigateToNextPage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Color") // Set your background color
                    .edgesIgnoringSafeArea(.all)
                backImage()
                Logo()
                    .offset(y: -160)
                AppName()
                    .offset(y: 110)
                shortText()
                    .offset(y: 180)
                
                // NavigationLink to the next view
                NavigationLink(destination: Onboarding(), isActive: $navigateToNextPage) {
                    EmptyView()
                }
                .hidden()
            }
            .onAppear {
                // Start the timer to navigate after 5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.3) {
                    navigateToNextPage = true
                }
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}
struct shortText:View {
    var body: some View {
        Text("Capture, Share and Compete!\n     Unleash your creativity!")
            .font(Font.custom("SF Pro", size: 20))
            .foregroundColor(.black)
    }
}
struct backImage:View {
    var body: some View {
        Image("backImage")
     
                       .resizable()
                       .scaledToFill()
                       .edgesIgnoringSafeArea(.all)
                   
    }
}

     struct Logo: View {
        @State private var opacitycent = false
        
        @State private var borderanim1: CGFloat = 0.0
        let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        
        @State private var borderanim2: CGFloat = 0.0
        let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            ZStack{

                
                AnimatedImage(name: "Logo4.GIF")

                    .padding(.leading, 40)
                
                .frame(width: 200, height: 300)
                .shadow(color: Color(white: 0.812, opacity: 0.78), radius: 13, x: 5, y: -5)

            }
        }
        
        
    }
    
    
    
    
    
    struct AppName : View {
        var body: some View {
            Image("appname")
                .resizable()
                .frame(width: 320, height: 70, alignment: .center)
        }
    }
   
  


#Preview {
    SplashView()
}

