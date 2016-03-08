module Exsules
  class Seeder
    def self.quiet
      SeedFu.quiet = true
      yield
      SeedFu.quiet = false
      puts "\nOK".colorize(:green)
    end
  end
end
