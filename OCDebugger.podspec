
Pod::Spec.new do |s|

  s.name         = "OCDebugger"
  s.version      = "0.0.1"
  s.summary      = "OCDebugger is an easy to use debugging toolset. You use OCDebugger debug your application on Web or iPhone."

  s.description  = <<-DESC
OCDebugger is an easy to use debugging toolset. You use OCDebugger debug your application on Web or iPhone. It's a client library and we provide an web application (OCDServer) holding all connection from iOS. Also, we provide a public web application here Open link, please feel free to use it, it's really stable.
                   DESC

  s.homepage     = "https://github.com/PonyCui/OCDebugger"

  s.license      = "MIT"

  s.author             = { "PonyCui" => "" }

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/PonyCui/OCDebugger" }#, :tag => "0.0.1" }

  s.source_files  = "OCDebugger", "OCDebugger/Classes", "OCDebugger/Classes/**", "OCDebugger/Classes/**/**", "OCDebugger/Classes/**/**/**", "OCDebugger/Classes/**/**/**/**", "OCDebugger/Classes/**/**/**/**/**"

  s.requires_arc = true

  s.dependency "Aspects"
  s.dependency "SocketRocket"

end
