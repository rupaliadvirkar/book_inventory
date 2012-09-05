class BooksController < ApplicationController
  
  before_filter :check_authorization, :only => [:create,:new,:edit,:update,:destroy]
  
  def check_authorization
    authorize! :manage, @book || Book.new
  end 
  
  # GET /books
  # GET /books.json
  def index
    @books = Book.find(:all,:include => {:comments => :user})
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end
  
  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id], :include => [{:comments => :user}, :authors])
    @comments = @book.comments
    @authors = @book.authors

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end
  
  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end
  
  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end
  
  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])
    respond_to do |format|
      begin
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully created.' }
          format.json { render json: @book, status: :created, location: @book }
        else
          format.html { render action: "new" }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      #This will take care of duplicate book entry in the scope of same authors only.  
      rescue InvalidBook => e
         @book.errors[:base] << e.to_s
         format.html { render action: "new" }
         format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    
    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
  
  def authors
    @authors = Author.find(:all, :include => {:comments => :user})
    respond_to do |format|
      format.html
      format.json { render json: @authors }
    end
  end
  
  def author
    @author = Author.find(params[:id], :include => {:comments => :user})    
    @comments = @author.comments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @author }
    end    
  end
  
  #comments for books & authors
  def comments
    type = params[:type].constantize
    object = type.find(params[:id])
    @comment = object.comments.build(params[:comment])
    if @comment.save
      if type.to_s == 'Book'
        redirect_to book_path(object), :notice => 'Comment posted successfully'
      elsif type.to_s == 'Author'
        redirect_to author_book_path(object), :notice => 'Comment posted successfully'
      end
    else
      if @comment.errors[:comment]
        if type.to_s == 'Book'
          redirect_to book_path(object), :notice => '1 error prohibited this comment from being saved: ' + @comment.errors.full_messages.join(",")
        elsif type.to_s == 'Author'
          redirect_to author_book_path(object), :notice => '1 error prohibited this comment from being saved: ' + @comment.errors.full_messages.join(",")
        end
      else
        render :text => 'Something went wrong'
      end
    end
  end  
end
