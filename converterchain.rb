#Finds dirs with flac files in them

flacdirs = Array.new
Dir.foreach(".") { |file| \
  if(File.directory?(file))
    Dir.foreach(file) { |subfile| \
      if(!subfile[-5..-1].nil?)
        if(subfile[-5..-1] == ".flac")
          flacdirs << file + "/"
          break
        end
      end
    }
  end
  }

# Clears out ones that already have wv files in a subfolder

finalFlacDirs = Array.new

  flacdirs.each { |fd| \
    found = false
    Dir.foreach(fd) { |file| \
      if(File.directory?(fd+"/"+file))
        Dir.foreach(fd+"/"+file) { |findwv| \
          if(findwv[-3..-1]==".wv")
            found = true
            break
          end
        }
      end
      }
        if(found==false)
          finalFlacDirs << fd
        end
    }

finalFlacDirs.each { |ffd| Dir.chdir(ffd); `~/Projects/GitHub/ruby/Z-Converter/converter.rb`; Dir.chdir("..") } 
