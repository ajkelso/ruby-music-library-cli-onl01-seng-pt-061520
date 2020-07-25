class Artist
    
    extend Concerns::Findable
    
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.destroy_all
        @@all.clear
    end


    def self.create(name)
        new_artist = Artist.new(name)
        new_artist.save
        new_artist   
    end

    def songs
        @songs
    end

    def add_song(song)
        unless song.artist
            song.artist = self
        end    
        @songs << song if !@songs.include?(song) 
    end

    def genres
        
        genres = self.songs.map {|song| song.genre }
        genres.uniq
    end


end