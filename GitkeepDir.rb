#!/usr/bin/ruby

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text)
  colorize(text, 31)
end
def green(text)
  colorize(text, 32)
end

class String
  def liste_rep(path = "")
    
    liste_exclus = [".", "..", ".git"]
    dir = Dir.open(self)
    liste_dir = dir.sort - liste_exclus

    if (liste_dir.size == 0)
      puts path + "/.gitkeep  " + green('Added')
      fd = File.new(path + "/.gitkeep", "w+")
      fd.close
    end
    
    liste_dir.each { |fichier|
      path = self + fichier
      case File.ftype(path)
      when "directory"
        (path + "/").liste_rep(path)
      end
    }
  end
end

"./".liste_rep()
  
