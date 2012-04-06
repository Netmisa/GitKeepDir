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

    if (liste_dir.size > 1 && liste_dir.index(".gitkeep") != nil)
      puts path + "/.gitkeep  " + red('Removed')
      File.delete(path + "/.gitkeep")
    end

    liste_dir.each { |fichier|
      path = self + fichier

      if (fichier != ".gitkeep")
        case File.ftype(path)
        when "directory"
          (path + "/").liste_rep(path)
        end
      end
    }
  end
end


if (ARGV.size == 0)
  "./".liste_rep()
else
  ARGV.each do|arg|
    "./".liste_rep(arg)
  end
end


  
