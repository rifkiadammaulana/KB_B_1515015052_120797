domains
hero = symbol
rating= real

predicates
nondeterm hero(hero, rating)
nondeterm hero_terpopuler(hero)
nondeterm hero_cacad(hero)

clauses
hero_terpopuler(Hero):-
hero(Hero, Rating),Rating>=7.5,
not(hero_cacad(Hero)).
hero("Techies",7.5).
hero("Phantom Asasin",9.0).
hero("Juggernut",6.0).
hero("Witch Doctor",7.5).
hero("Rubick",8.5).
hero("Underlord",7.0).
hero_cacad("Juggernut").
hero_cacad("Techies").

goal
write("Hero terpopuler adalah: "),
hero_terpopuler(Name), write(Name),nl,fail.