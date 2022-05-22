const Map<String, dynamic> moviesListResponse = {
  "data": [
    {
      "id": "0",
      "title": "Spider-Man: No Way Home",
      "description":
          "With Spider-Man's identity now revealed, our friendly neighborhood web-slinger is unmasked and no longer able to separate his normal life as Peter Parker from the high stakes of being a superhero. When Peter asks for help from Doctor Strange, the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/0.jpg",
    },
    {
      "id": "1",
      "title": "Eternals",
      "description":
          "The Eternals, a race of immortal beings with superhuman powers who have secretly lived on Earth for thousands of years, reunite to battle the evil Deviants.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/1.jpg",
    },
    {
      "id": "2",
      "title": "Shang-Chi and the Legend of the Ten Rings",
      "description":
          "Martial-arts master Shang-Chi confronts the past he thought he left behind when he's drawn into the web of the mysterious Ten Rings organization.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/2.jpg",
    },
    {
      "id": "3",
      "title": "Avengers: Endgame",
      "description":
          "Adrift in space with no food or water, Tony Stark sends a message to Pepper Potts as his oxygen supply starts to dwindle. Meanwhile, the remaining Avengers -- Thor, Black Widow, Captain America and Bruce Banner -- must figure out a way to bring back their vanquished allies for an epic showdown with Thanos -- the evil demigod who decimated the planet and the universe.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/3.jpg",
    },
    {
      "id": "4",
      "title": "Doctor Strange in the Multiverse of Madness",
      "description":
          "Following the further adventures of Dr. Stephen Strange and his research on the Time Stone.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/4.jpg",
    },
    {
      "id": "5",
      "title": "Thor: Ragnarok",
      "description":
          "Imprisoned on the other side of the universe, the mighty Thor finds himself in a deadly gladiatorial contest that pits him against the Hulk, his former ally and fellow Avenger. Thor's quest for survival leads him in a race against time to prevent the all-powerful Hela from destroying his home world and the Asgardian civilization.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/5.jpg",
    },
    {
      "id": "6",
      "title": "Iron Man 3",
      "description":
          "Plagued with worry and insomnia since saving New York from destruction, Tony Stark (Robert Downey Jr.), now, is more dependent on the suits that give him his Iron Man persona -- so much so that every aspect of his life is affected, including his relationship with Pepper (Gwyneth Paltrow). After a malevolent enemy known as the Mandarin (Ben Kingsley) reduces his personal world to rubble, Tony must rely solely on instinct and ingenuity to avenge his losses and protect the people he loves.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/6.jpg",
    },
    {
      "id": "7",
      "title": "Guardians of the Galaxy",
      "description":
          "Brash space adventurer Peter Quill (Chris Pratt) finds himself the quarry of relentless bounty hunters after he steals an orb coveted by Ronan, a powerful villain. To evade Ronan, Quill is forced into an uneasy truce with four disparate misfits: gun-toting Rocket Raccoon, treelike-humanoid Groot, enigmatic Gamora, and vengeance-driven Drax the Destroyer. But when he discovers the orb's true power and the cosmic threat it poses, Quill must rally his ragtag group to save the universe.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/7.jpg",
    },
    {
      "id": "8",
      "title": "Captain Marvel",
      "description":
          "Captain Marvel is an extraterrestrial Kree warrior who finds herself caught in the middle of an intergalactic battle between her people and the Skrulls. Living on Earth in 1995, she keeps having recurring memories of another life as U.S. Air Force pilot Carol Danvers. With help from Nick Fury, Captain Marvel tries to uncover the secrets of her past while harnessing her special superpowers to end the war with the evil Skrulls.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/8.jpg",
    },
    {
      "id": "9",
      "title": "The Suicide Squad",
      "description":
          "The government sends the most dangerous supervillains in the world -- Bloodsport, Peacemaker, King Shark, Harley Quinn and others -- to the remote, enemy-infused island of Corto Maltese. Armed with high-tech weapons, they trek through the dangerous jungle on a search-and-destroy mission, with only Col. Rick Flag on the ground to make them behave.",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/9.jpg",
    },
    {
      "id": "10",
      "title": "The Incredible Hulk",
      "description":
          "Scientist Bruce Banner (Edward Norton) desperately seeks a cure for the gamma radiation that contaminated his cells and turned him into The Hulk. Cut off from his true love Betty Ross (Liv Tyler) and forced to hide from his nemesis, Gen. Thunderbolt Ross (William Hurt), Banner soon comes face-to-face with a new threat: a supremely powerful enemy known as The Abomination (Tim Roth).",
      "isFavorite": "false",
      "imagePath":
          "https://raw.githubusercontent.com/MichaelCadavillo/flutter_web_sample/master/assets/images/10.jpg",
    },
  ]
};

Map<String, dynamic> getMovieDetails(String id) {
  if (moviesListResponse['data'][0]['id'] == id) {
    return moviesListResponse['data'][0];
  } else if (moviesListResponse['data'][1]['id'] == id) {
    return moviesListResponse['data'][1];
  } else if (moviesListResponse['data'][2]['id'] == id) {
    return moviesListResponse['data'][2];
  } else if (moviesListResponse['data'][3]['id'] == id) {
    return moviesListResponse['data'][3];
  } else if (moviesListResponse['data'][4]['id'] == id) {
    return moviesListResponse['data'][4];
  } else if (moviesListResponse['data'][5]['id'] == id) {
    return moviesListResponse['data'][5];
  } else if (moviesListResponse['data'][6]['id'] == id) {
    return moviesListResponse['data'][6];
  } else if (moviesListResponse['data'][7]['id'] == id) {
    return moviesListResponse['data'][7];
  } else if (moviesListResponse['data'][8]['id'] == id) {
    return moviesListResponse['data'][8];
  } else if (moviesListResponse['data'][9]['id'] == id) {
    return moviesListResponse['data'][9];
  } else if (moviesListResponse['data'][10]['id'] == id) {
    return moviesListResponse['data'][10];
  }
  return {"data": null};
}
