['alcides', 'kamila', 'angel', 'anyerlis', 'michael', 'edixon', 'carlos', 'keymar', 'joel'].each do |name|
    User.create(
        email: "#{name}@gmail.com", 
        password: '123456')
end 

puts 'Users has been created'
owner = User.find_by(email: 'keymar@gmail.com')

info = [
    ['nis', 'armar planilla de amazon', ['1:1','2:2','3:random']],
    ['traduccion', 'traducir a aleman las categorias de beauty', ['4:1','5:2','6:random']],
    ['categorizacion', 'Categorizar los productos del cliente x', ['7:1','8:2','9:random']]
]

info.each do |category, description, participant_set|
    Category.create!(
        name: category,
        description: '--'
    )

    puts 'Category have been created' if Category.count == 3

    participants = participant_set.map do |participant|
        id, raw_role = participant.split(':')
        role = raw_role == 'random' ? [1,2].sample : raw_role

        Participant.new(
            user: User.find(id.to_i),
            role: role.to_i
        )
    end

    Task.create!(
        name: category,
        description: description,
        category: Category.find_by(name: category),
        due_date: Date.today + 2.days,
        owner: owner,
        participating_users: participants
    )
end

puts 'Task have been created' if Task.count == 3