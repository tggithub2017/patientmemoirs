class BlogPostController < DashboardpageController

    def insert
        redirect_to root_path 
    end

    def post 
        @blog_post = BlogPost.new({:image => " ", :image1 => " ", :image2 => " "})
    end

end
