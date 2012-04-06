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
  def liste_rep()
    
    liste_exclus = [".", "..", ".git"]
    dir = Dir.open(self)
    liste_dir = dir.sort - liste_exclus
    
    liste_dir.each { |fichier|
      path = self + fichier

      case File.ftype(path)
      when "directory"
        vide = %x(ls "#{path}/")

        if (vide == "")
          puts self + fichier + "/.gitkeep  " + green('Added')
          fd = File.new(self + fichier + "/.gitkeep", "w+")
          fd.close
        end
      end
    }
  end
end

"./".liste_rep()
  
