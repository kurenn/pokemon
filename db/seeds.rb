trainer = Trainer.find_or_create_by(name: 'Ash Ketchum',
                                    email: 'ash@ketchum.local')

trainer.password = 'pikachu'
trainer.save
