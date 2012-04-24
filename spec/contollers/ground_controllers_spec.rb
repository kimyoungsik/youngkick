require 'spec_helper'

describe GroundsController,:type => :controller do
  # render_views
  before(:each) do
     FactoryGirl.create(:team)
     FactoryGirl.create(:position)
  end
  
  describe "GET 'index'" do
    
    describe "for signed_in users" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
        @grounds = []
        5.times do |n|
          @grounds << FactoryGirl.create(:ground, :user => @user, :title => "#{n}title" )
        end
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      # it "should have an payment_method in each entry" do
      #        get :index
      #        @grounds[0..2].each do |ground|
      #          page.has_content?('cashaaa')
      #        end
      #      end
    end
  end
  
  describe "POST 'create'" do
    
    describe "unsigned_in users" do   
      it "should deny access to 'create'" do
          post :create
          response.should redirect_to(user_session_url)
      end     
    end
    
    describe "for signed_in users" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      describe "success" do
        before(:each) do
          @attr = {
                   :user_id => @user,
                   :title => "puchonsoccer",
                   :location => "puchon city ground",
                   :datetime => Time.now,
                   :forwardcount => 2,
                   :midfieldcount => 4,
                   :backcount => 4,
                   :keepercount => 1,
                   # :status => "pending",
                   :limit => 20,
                   :limitday => 2}
        end
        it "should create a entry" do
          lambda do
            post :create, :ground => @attr
          end.should change(Ground, :count).by(1)
        end
      end
      
      describe "failure" do
        before(:each) do
          @attr = {
                   :user_id => @user,
                   :title => "",
                   :location => "",
                   :datetime => Time.now,
                   :forwardcount => nil,
                   :midfieldcount => nil,
                   :backcount => nil,
                   :keepercount => nil,
                   :status => "test",
                   :limit => nil,
                   :limitday => nil}
        end
        it "should not create a entry" do
          lambda do
            post :create, :ground => @attr
          end.should_not change(Ground, :count)
        end
        it "should redirect to ground new page" do
          post :create, :ground => @attr
          response.should render_template('new')
        end
      end
    end
  end
  
  describe "PUT 'update'" do  
    describe "for an autorized user" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
        @ground = FactoryGirl.create(:ground, :user => @user)
      end
      describe "unsigned_in users" do   
        before(:each) do
         sign_out @user
         @attr = { :user_id => @user, :location => "new location"}
        end

        it "should deny access to 'index'" do
           put :update, :id => @ground, :ground => @attr
           response.should redirect_to(user_session_url)
        end     
      end
      describe "signed_in users" do  
        describe "success" do
          before(:each) do
            @attr = {  :location => "new location", :limitday => 4}
          end
          it "should change the entry's attributes" do
            put :update, :id => @ground, :ground => @attr
            @ground.reload
            @ground.location.should == @attr[:location]
            @ground.limitday.should == @attr[:limitday]
          end
          it "should redirect to the entry show page" do
            put :update, :id => @ground, :ground => @attr
            response.should redirect_to(ground_path(@ground))
          end
        end
      
        describe "failure" do  
          before (:each) do
            @attr = { :user_id => @user, :location => "", :limitday => nil}
          end   
          it "should render the 'edit' page" do 
            put :update, :id => @ground, :ground => @attr
            response.should render_template('edit')
          end
        end 
      end
    end
  
  
    describe "for an unauthorized user" do 
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        @ground = FactoryGirl.create(:ground, :user => @user)
        @wrong_user = User.create!(:email => "other@headflow.net", :password => "dudtlr")
        sign_in @wrong_user
      end    
    
      describe "failure" do  
        before (:each) do
          @attr = {  :location => "new location", :limitday => 4}
        end   
        it "should render the 'edit' page" do 
          put :update, :id => @ground, :ground => @attr
          response.should redirect_to(grounds_path)
        end
      end
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
      @ground = FactoryGirl.create(:ground, :user => @user)
    end
    
    it "should be successful" do
      get :show, :id => @ground
      response.should be_success
    end
    
    it "should find the right show" do
      get :show, :id => @ground
      assigns(:ground).should == @ground
    end
    # it "should have the right title" do
    #   get :show, :id => @ground
    #   response.should have_selector("p", :content => @entry.amount)
    # end    # 
    # it "should include the user's name" do
    #   get :show, :id => @ground
    #   page.has_content?("abcde")
    # end
  end
  
  describe "DELETE 'destroy'" do

     describe "for an unauthorized user" do 
       before(:each) do
         @request.env["devise.mapping"] = Devise.mappings[:user]
         @user = FactoryGirl.create(:user)
         @ground = FactoryGirl.create(:ground, :user => @user)
         @wrong_user = User.create!(:email => "other@headflow.net", :password => "dudtlr")
         sign_in @wrong_user
       end    
       it "should deny access" do
         delete :destroy, :id => @ground
         response.should redirect_to(grounds_path)
       end
       it "should not destroy the seed" do
         lambda do
           delete :destroy, :id => @ground
         end.should_not change(Ground, :count)        
       end
     end

     describe "for an authorized user" do
       before(:each) do
         @request.env["devise.mapping"] = Devise.mappings[:user]
          @user = FactoryGirl.create(:user)
          sign_in @user
          @ground = FactoryGirl.create(:ground, :user => @user)
       end
       it "should destroy the seed" do
          lambda do
             delete :destroy, :id => @ground
          end.should change(Ground, :count).by(-1)
       end
     end
   end
end
  