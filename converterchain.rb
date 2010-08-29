#!/usr/bin/env ruby

#Finds dirs with flac files in them
def findFlacFiles()
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
  return flacdirs;
end

# Clears out ones that already have wv files in a subfolder
def clearWVDirs(flacdirs)
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
  return finalFlacDirs
end

def processDirs(finalFlacDirs)
  finalFlacDirs.each { |ffd| Dir.chdir(ffd); `~/bin/zconv`; Dir.chdir("..") } 
end

processDirs(clearWVDirs(findFlacFiles()))
