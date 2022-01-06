require 'rails_helper'


RSpec.describe "/pets", type: :request do
  let(:valid_attributes) {
    { nome: 'Buddy', raca: 'Pastor Alemão', porte: 'medio' }
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Pet.create! valid_attributes
      get pets_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      pet = Pet.create! valid_attributes
      get pet_url(pet), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Pet" do
        expect {
          post pets_url,
               params: { pet: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Pet, :count).by(1)
      end

      it "renders a JSON response with the new pet" do
        post pets_url,
             params: { pet: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Pet" do
        expect {
          post pets_url,
               params: { pet: invalid_attributes }, as: :json
        }.to change(Pet, :count).by(0)
      end

      it "renders a JSON response with errors for the new pet" do
        post pets_url,
             params: { pet: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        valid_attributes.merge(porte: 'grande')
      }

      it "updates the requested pet" do
        pet = Pet.create! valid_attributes
        patch pet_url(pet),
              params: { pet: new_attributes }, headers: valid_headers, as: :json
        pet.reload
        expect(pet.porte).to eq 'grande'
      end

      it "renders a JSON response with the pet" do
        pet = Pet.create! valid_attributes
        patch pet_url(pet),
              params: { pet: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { nome: nil } }

      it "renders a JSON response with errors for the pet" do
        pet = Pet.create! valid_attributes
        patch pet_url(pet),
              params: { pet: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested pet" do
      pet = Pet.create! valid_attributes
      expect {
        delete pet_url(pet), headers: valid_headers, as: :json
      }.to change(Pet, :count).by(-1)
    end
  end
end
