require 'pry'

class Song

    attr_accessor :name
    attr_reader :artist, :genre
    

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) if artist   
        self.genre=(genre) if genre
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
        new_song = Song.new(name)
        new_song.save
        new_song   
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        unless genre.songs.include?(self)
            genre.songs << self
        end
    end

    def self.find_by_name(name)
        Song.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        if self.find_by_name(name)
            self.find_by_name(name)
        else
            self.create(name)
        end
    end

    def self.new_from_filename(filename)
        # song = self.new(filename)
        name = filename.split("-").map(&:strip)[1]
        artist = Artist.find_or_create_by_name(filename.split("-").map(&:strip)[0])
        genre = Genre.find_or_create_by_name(filename.gsub(".mp3", "").split(" - ").map(&:strip)[2])
        self.new(name, artist, genre)  
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        @@all << song
    end





end

