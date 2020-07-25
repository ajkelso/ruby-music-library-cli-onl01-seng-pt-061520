class MusicLibraryController

    def initialize(path = "./db/mp3s")
        @path = path
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        response = gets
        
        if response == "list songs"
            list_songs
        elsif response == "list artists"
            list_artists
        elsif response == "list genres"
            list_genres
        elsif response == "list artist"
            list_songs_by_artist
        elsif response == "list genre"
            list_songs_by_genre
        elsif response == "play song"
            play_song
        elsif response != "exit"
            self.call
        end

    end

    def list_songs
        
        Song.all.sort_by {|song| song.name}.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end

       
    end

    def list_artists
        Artist.all.sort_by {|artist| artist.name}.each_with_index do |artist, index|
            
            puts "#{index + 1}. #{artist.name}"
            
        end
    end

    def list_genres
        Genre.all.sort_by {|genre| genre.name}.each_with_index do |genre, index|  
            puts "#{index + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist = gets.chomp
        artist = Artist.find_or_create_by_name(artist)
        artist.songs.sort_by {|song| song.name}.each_with_index do |song, index|
            puts "#{index + 1}. #{song.name} - #{song.genre.name}"
        end   
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = gets.chomp
        genre = Genre.find_or_create_by_name(genre)
        genre.songs.sort_by {|song| song.name}.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.chomp.to_i
        list = Song.all.sort_by {|song| song.name}
        if (song_number > 0) && (song_number <= list.length)
            song = list[song_number - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

end
