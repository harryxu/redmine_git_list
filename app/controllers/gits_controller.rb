class GitsController < ApplicationController
    def index
        @repos = []
        @user = 'git'
        @host = 'gks1.3322.org'
        @reposPath = '/home/git/repositories'
        traverse_dir(@reposPath, @repos)
    end

    def all
        
    end

    private

    def traverse_dir(file_path, list)
        if File.directory? file_path
            begin
                Dir.foreach(file_path) do |file|
                    fullPath = file_path + '/' + file

                    if file!="." and file!=".." and File.directory? fullPath \
                        and file != 'gitosis-admin.git'

                        if /\.git$/.match(fullPath) != nil
                            list.push(createRepoInfo(fullPath))
                        else
                            traverse_dir(file_path+'/'+file, list)
                        end
                    end
                end
            rescue
            end
        end
    end

    def createRepoInfo(path)
        re = Regexp.new(@reposPath + '/')
        gitUrl = @user+'@'+@host+':'+path.sub(re, '')
        info = {'url' => gitUrl, 'desc' => ''}

        descPath = path + '/description'
        if File.readable?(descPath)
            s = ''
            file = File.new(descPath, 'r')
            while (line = file.gets)
                s = s + line
            end
            info['desc'] = s
        end
        return info
    end
end
