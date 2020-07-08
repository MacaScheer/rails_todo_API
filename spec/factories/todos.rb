FactoryBot.define do
    factory :todo do
        title { Faker::Lorem.word }
        created_by { Faker::Nunmber.number(10) }
    end
end