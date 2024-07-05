import 'package:ticketron/models/formal.dart';

 List<User> usersData = [
    User(
      userId: '0001',
      name: 'John Doe',
      email: 'john.doe@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    User(
      userId: '0002',
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    User(
      userId: '0003',
      name: 'Michael Johnson',
      email: 'michael.johnson@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    User(
      userId: '0004',
      name: 'Emily Brown',
      email: 'emily.brown@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/women/2.jpg",
    ),
    User(
      userId: '0005',
      name: 'Daniel Williams',
      email: 'daniel.williams@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/men/3.jpg",
    ),
    User(
      userId: '0006',
      name: 'Olivia Garcia',
      email: 'olivia.garcia@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/women/3.jpg",
    ),
    User(
      userId: '0007',
      name: 'Matthew Martinez',
      email: 'matthew.martinez@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    User(
      userId: '0008',
      name: 'Sophia Hernandez',
      email: 'sophia.hernandez@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    User(
      userId: '0009',
      name: 'Alexander Lopez',
      email: 'alexander.lopez@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    User(
      userId: '0010',
      name: 'Isabella Martinez',
      email: 'isabella.martinez@example.com',
      avatarUrl: "https://randomuser.me/api/portraits/women/2.jpg",
    ),
  ];


List<Organizer> dummyOrganizers = [
  Organizer(
    organizerId: 'a8b87e19-37d8-4f1a-bf0e-727350683fe5',
    name: 'Event Organizers Inc.',
    isVerified: true,
    logoUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    category: 'Business & Networking',
    about: 'Event Organizers Inc. specializes in corporate events and networking opportunities.',
  ),
  Organizer(
    organizerId: 'b6e7cfdb-4985-43cd-9f97-0f3b94a97f3c',
    name: 'Arts & Culture Events',
    isVerified: true,
    logoUrl: 'https://content.jdmagicbox.com/comp/ernakulam/m4/0484px484.x484.140206113128.a9m4/catalogue/we-create-events-panampilly-nagar-ernakulam-event-management-companies-nsobpzm660.jpg',
    category: 'Arts & Culture',
    about: 'We promote local artists and cultural events, fostering creativity and community engagement.',
  ),
];

List<String> avatars = [
  "https://randomuser.me/api/portraits/men/1.jpg",
  "https://randomuser.me/api/portraits/women/1.jpg",
  "https://randomuser.me/api/portraits/men/2.jpg",
  "https://randomuser.me/api/portraits/women/2.jpg",
  "https://randomuser.me/api/portraits/men/3.jpg",
  "https://randomuser.me/api/portraits/women/3.jpg",
];

List<Event> dummyEvents = [
  Event(
    eventId: 'dbf789f1-ec6a-4a07-86a0-3b34f524a0fd',
    title: 'Networking Mixer 2024',
    date: DateTime(2024, 8, 15),
    time: '18:00 - 20:00',
    location: 'Business Hub Center',
    price: Price(premiumPrice: 50.0, regularPrice: 30.0),
    description: 'Join us for an evening of networking and business insights. Connect with industry leaders and professionals over refreshments and engaging discussions.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Welcome',
        speaker: 'Event Organizers Inc.',
        startTime: '18:00',
        endTime: '18:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Panel Discussion: Future Trends in Business',
        speaker: 'Industry Experts',
        startTime: '18:30',
        endTime: '19:30',
        speakerImageUrl: avatars[0],
      ),
      AgendaItem(
        title: 'Networking Session',
        speaker: 'Event Organizers Inc.',
        startTime: '19:30',
        endTime: '20:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
    ],
    images: [
      'https://events.ats.co.za/images/event3.jpg',
      'https://4kwallpapers.com/images/wallpapers/fluidic-glossy-gradient-background-purple-background-3440x1440-7641.jpg'
    ],
    ticketsLeft: 50,
    category: 'Business & Networking',
    totalCapacityNeeded: 100,
  ),
  Event(
    eventId: 'e31e47cc-1a4a-44e4-856b-832e2b4f4e11',
    title: 'Art Exhibition: Modern Visions',
    date: DateTime(2024, 9, 5),
    time: '10:00 - 18:00',
    location: 'City Art Gallery',
    price: Price(regularPrice: 20.0, premiumPrice: 30.0),
    description: 'Explore the latest in modern art with works from renowned contemporary artists. This exhibition showcases diverse perspectives and creative expressions.',
    organizer: dummyOrganizers[1],
    agenda: [
      AgendaItem(
        title: 'Welcome and Introduction to the Exhibition',
        speaker: 'Arts & Culture Events',
        startTime: '10:00',
        endTime: '10:30',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Artist Talk: Exploring Modern Art Movements',
        speaker: 'Featured Artists',
        startTime: '11:00',
        endTime: '12:30',
        speakerImageUrl: avatars[1],
      ),
      AgendaItem(
        title: 'Guided Tour of the Exhibition',
        speaker: 'Arts & Culture Events',
        startTime: '13:00',
        endTime: '14:00',
        speakerImageUrl: avatars[2],
      ),
    ],
    images: [
      'https://static.vecteezy.com/system/resources/previews/000/677/949/non_2x/liquid-gradient-color-background-fluid-gradient.jpg',
      'https://www.cityartgallery.com/exhibitions/modern-visions/gallery2.jpg',
    ],
    ticketsLeft: 150,
    category: 'Arts & Culture',
    totalCapacityNeeded: 200,
  ),
  Event(
    eventId: '8db6852b-29c1-4e2d-b44a-6159c4b953cc',
    title: 'Tech Conference 2024',
    date: DateTime(2024, 10, 12),
    time: '09:00 - 17:00',
    location: 'Tech Hub Convention Center',
    price: Price(premiumPrice: 80.0, regularPrice: 50.0),
    description: 'Join industry leaders and tech enthusiasts for a full day of keynote presentations, workshops, and networking opportunities. Discover the latest in technology trends and innovations.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Welcome',
        speaker: 'Event Organizers Inc.',
        startTime: '09:00',
        endTime: '09:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Keynote Address: Future of Artificial Intelligence',
        speaker: 'Dr. Sarah Johnson',
        startTime: '09:30',
        endTime: '10:30',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Panel Discussion: Blockchain and Cryptocurrency',
        speaker: 'Industry Experts',
        startTime: '10:30',
        endTime: '11:30',
        speakerImageUrl: avatars[3],
      ),
      AgendaItem(
        title: 'Networking Lunch',
        speaker: 'Event Organizers Inc.',
        startTime: '12:00',
        endTime: '13:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Workshop: UX Design Principles',
        speaker: 'John Smith',
        startTime: '13:30',
        endTime: '15:00',
        speakerImageUrl: avatars[4],
      ),
      AgendaItem(
        title: 'Closing Remarks and Networking',
        speaker: 'Event Organizers Inc.',
        startTime: '15:30',
        endTime: '17:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
    ],
    images: [
      'https://i0.wp.com/www.titanui.com/wp-content/uploads/2014/02/04/3D-Abstract-Gradient-Background-Vector-02.jpg',
      'https://i0.wp.com/www.titanui.com/wp-content/uploads/2014/02/04/3D-Abstract-Gradient-Background-Vector-02.jpg',
    ],
    ticketsLeft: 80,
    category: 'Technology',
    totalCapacityNeeded: 200,
  ),
  Event(
    eventId: 'dd22cf0d-5d06-4cc8-a439-58c7b1e9c098',
    title: 'Health & Wellness Seminar',
    date: DateTime(2024, 11, 8),
    time: '14:00 - 18:00',
    location: 'Wellness Center',
    price: Price(regularPrice: 25.0, premiumPrice: 56.0),
    description: 'Explore holistic approaches to health and wellness with expert speakers and interactive workshops. Discover new ways to enhance your physical and mental well-being.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Welcome',
        speaker: 'Event Organizers Inc.',
        startTime: '14:00',
        endTime: '14:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Keynote Speech: Mindfulness in Everyday Life',
        speaker: 'Dr. Emily Adams',
        startTime: '14:30',
        endTime: '15:30',
        speakerImageUrl: avatars[5],
      ),
      AgendaItem(
        title: 'Panel Discussion: Nutrition and Healthy Eating',
        speaker: 'Nutrition Experts',
        startTime: '15:30',
        endTime: '16:30',
        speakerImageUrl: avatars[0],
      ),
      AgendaItem(
        title: 'Workshop: Yoga and Meditation Techniques',
        speaker: 'Yoga Instructors',
        startTime: '16:30',
        endTime: '18:00',
        speakerImageUrl: avatars[1],
      ),
    ],
    images: [
      'https://i0.wp.com/www.titanui.com/wp-content/uploads/2014/02/04/3D-Abstract-Gradient-Background-Vector-02.jpg',
      'https://i0.wp.com/www.titanui.com/wp-content/uploads/2014/02/04/3D-Abstract-Gradient-Background-Vector-02.jpg',
    ],
    ticketsLeft: 100,
    category: 'Health & Wellness',
    totalCapacityNeeded: 150,
  ),
  Event(
    eventId: '03b3a073-cc0d-44b8-84e1-10649e8a6d5a',
    title: 'Startup Pitch Competition',
    date: DateTime(2024, 12, 1),
    time: '13:00 - 17:00',
    location: 'Innovation Hub',
    price: Price(regularPrice: 10.0, premiumPrice: 20.0),
    description: 'Watch aspiring entrepreneurs pitch their innovative business ideas to a panel of investors and industry experts. Vote for your favorite startup and network with fellow attendees.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Welcome',
        speaker: 'Event Organizers Inc.',
        startTime: '13:00',
        endTime: '13:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Startup Pitches: Session 1',
        speaker: 'Entrepreneurs',
        startTime: '13:30',
        endTime: '15:00',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Networking Break',
        speaker: 'Event Organizers Inc.',
        startTime: '15:00',
        endTime: '15:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Startup Pitches: Session 2',
        speaker: 'Entrepreneurs',
        startTime: '15:30',
        endTime: '17:00',
        speakerImageUrl: avatars[3],
      ),
    ],
    images: [
      'https://static.vecteezy.com/system/resources/previews/011/078/561/non_2x/abstract-technology-dots-halftone-effect-particles-vibrant-gradient-color-background-and-texture-vector.jpg',
      'https://static.vecteezy.com/system/resources/previews/011/078/561/non_2x/abstract-technology-dots-halftone-effect-particles-vibrant-gradient-color-background-and-texture-vector.jpg',
    ],
    ticketsLeft: 120,
    category: 'Entrepreneurship',
    totalCapacityNeeded: 150,
  ),
  Event(
    eventId: 'b7d0df03-4a9f-46e5-a9f2-af324b76e381',
    title: 'Music Festival 2025',
    date: DateTime(2025, 1, 20),
    time: '12:00 - 23:00',
    location: 'City Park',
    price: Price(premiumPrice: 100.0, regularPrice: 70.0),
    description: 'Celebrate a day of music, food, and fun at the annual city music festival. Enjoy live performances from top artists, delicious food trucks, and a vibrant atmosphere.',
    organizer: dummyOrganizers[1],
    agenda: [
      AgendaItem(
        title: 'Welcome and Opening Act',
        speaker: 'Music Festival Organizers',
        startTime: '12:00',
        endTime: '12:30',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Live Performances: Session 1',
        speaker: 'Featured Artists',
        startTime: '13:00',
        endTime: '15:00',
        speakerImageUrl: avatars[4],
      ),
      AgendaItem(
        title: 'Food Truck Festival',
        speaker: 'Local Food Vendors',
        startTime: '15:00',
        endTime: '17:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Live Performances: Session 2',
        speaker: 'Featured Artists',
        startTime: '17:00',
        endTime: '19:00',
        speakerImageUrl: avatars[5],
      ),
      AgendaItem(
        title: 'Closing Ceremony and Fireworks',
        speaker: 'Music Festival Organizers',
        startTime: '20:00',
        endTime: '23:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
    ],
    images: [
      'https://i.pinimg.com/originals/d1/cf/9c/d1cf9c9a25ed6e5cc87aaa99dedc4eb7.jpg',
      'https://i.pinimg.com/originals/d1/cf/9c/d1cf9c9a25ed6e5cc87aaa99dedc4eb7.jpg',
    ],
    ticketsLeft: 200,
    category: 'Music & Arts',
    totalCapacityNeeded: 300,
  ),
  Event(
    eventId: 'f14f529e-8c22-46f4-b2c2-84a99cf076b0',
    title: 'Educational Workshop: Future of Learning',
    date: DateTime(2025, 2, 15),
    time: '09:30 - 16:00',
    location: 'Learning Center',
    price: Price(regularPrice: 15.0, premiumPrice: 20.0),
    description: 'Explore innovative approaches to education and learning with leading educators and technology experts. Gain insights into the future of learning and teaching.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Welcome',
        speaker: 'Event Organizers Inc.',
        startTime: '09:30',
        endTime: '10:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Keynote Address: Digital Transformation in Education',
        speaker: 'Dr. Michael Brown',
        startTime: '10:00',
        endTime: '11:00',
        speakerImageUrl: avatars[0],
      ),
      AgendaItem(
        title: 'Panel Discussion: Future Skills for Students',
        speaker: 'Education Experts',
        startTime: '11:00',
        endTime: '12:30',
        speakerImageUrl: avatars[1],
      ),
      AgendaItem(
        title: 'Workshop: Integrating Technology in the Classroom',
        speaker: 'Technology Specialists',
        startTime: '13:30',
        endTime: '15:30',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Closing Remarks and Networking',
        speaker: 'Event Organizers Inc.',
        startTime: '15:30',
        endTime: '16:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
    ],
    images: [
      'https://img.freepik.com/free-vector/education-technology-futuristic-background-vector-gradient-blue-digital-remix_53876-114092.jpg',
      'https://img.freepik.com/free-vector/education-technology-futuristic-background-vector-gradient-blue-digital-remix_53876-114092.jpg',
    ],
    ticketsLeft: 80,
    category: 'Education',
    totalCapacityNeeded: 120,
  ),
  Event(
    eventId: 'f7c3085c-ba14-4648-bd8d-724d55a0a4a8',
    title: 'Fashion Show: Spring Collection',
    date: DateTime(2025, 3, 22),
    time: '19:00 - 22:00',
    location: 'Fashion Center',
    price: Price(regularPrice: 35.0, premiumPrice: 50.0),
    description: 'Experience the latest trends in fashion with an exclusive showcase of spring collections. Featuring top designers, models, and stylish surprises.',
    organizer: dummyOrganizers[1],
    agenda: [
      AgendaItem(
        title: 'Welcome and Opening Remarks',
        speaker: 'Fashion Show Organizers',
        startTime: '19:00',
        endTime: '19:30',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Spring Collection Showcase',
        speaker: 'Featured Designers',
        startTime: '20:00',
        endTime: '21:30',
        speakerImageUrl: avatars[3],
      ),
      AgendaItem(
        title: 'Fashion Networking and Social Hour',
        speaker: 'Fashion Show Organizers',
        startTime: '21:30',
        endTime: '22:00',
        speakerImageUrl: avatars[2],
      ),
    ],
    images: [
      'https://img.freepik.com/free-vector/paper-style-gradient-blue-wavy-background_23-2149121741.jpg',
      'https://img.freepik.com/free-vector/paper-style-gradient-blue-wavy-background_23-2149121741.jpg',
    ],
    ticketsLeft: 90,
    category: 'Fashion & Beauty',
    totalCapacityNeeded: 150,
  ),
  Event(
    eventId: '9d9d06ac-2f42-4e43-905d-95c1998cf2a7',
    title: 'Food Festival: Taste of the World',
    date: DateTime(2025, 4, 18),
    time: '11:00 - 19:00',
    location: 'City Square',
    price: Price(regularPrice: 25.0, premiumPrice: 40.0),
    description: 'Indulge in a culinary journey with flavors from around the globe. Discover delicious dishes, cooking demonstrations, and family-friendly entertainment at this vibrant food festival.',
    organizer: dummyOrganizers[1],
    agenda: [
      AgendaItem(
        title: 'Welcome and Opening Ceremony',
        speaker: 'Food Festival Organizers',
        startTime: '11:00',
        endTime: '11:30',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Live Cooking Demonstrations',
        speaker: 'International Chefs',
        startTime: '12:00',
        endTime: '14:00',
        speakerImageUrl: avatars[4],
      ),
      AgendaItem(
        title: 'Food Tasting Stations',
        speaker: 'Local and Global Vendors',
        startTime: '14:00',
        endTime: '17:00',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Entertainment Performances',
        speaker: 'Local Artists',
        startTime: '17:00',
        endTime: '19:00',
        speakerImageUrl: avatars[5],
      ),
    ],
    images: [
      'https://static.vecteezy.com/system/resources/previews/010/556/604/original/abstract-frashy-colorful-gradient-background-futuristic-papercut-wallpaper-back-to-school-theme-geometric-banner-background-vector.jpg',
      'https://static.vecteezy.com/system/resources/previews/010/556/604/original/abstract-frashy-colorful-gradient-background-futuristic-papercut-wallpaper-back-to-school-theme-geometric-banner-background-vector.jpg',
    ],
    ticketsLeft: 180,
    category: 'Food & Drink',
    totalCapacityNeeded: 250,
  ),
  Event(
    eventId: '04abfc35-683e-42c3-bfa5-9c13f03244f4',
    title: 'Environmental Summit 2025',
    date: DateTime(2025, 5, 10),
    time: '09:00 - 17:00',
    location: 'Green Innovation Center',
    price: Price(regularPrice: 20.0, premiumPrice: 40.0),
    description: 'Join global leaders, scientists, and activists to discuss pressing environmental issues and innovative solutions. Collaborate on strategies for a sustainable future.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Welcome',
        speaker: 'Event Organizers Inc.',
        startTime: '09:00',
        endTime: '09:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Keynote Address: Climate Change and Policy',
        speaker: 'Dr. Maria Garcia',
        startTime: '09:30',
        endTime: '10:30',
        speakerImageUrl: avatars[0],
      ),
      AgendaItem(
        title: 'Panel Discussion: Innovations in Renewable Energy',
        speaker: 'Environmental Experts',
        startTime: '10:30',
        endTime: '12:00',
        speakerImageUrl: avatars[1],
      ),
      AgendaItem(
        title: 'Workshop: Sustainable Practices in Business',
        speaker: 'Industry Leaders',
        startTime: '13:00',
        endTime: '15:00',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Closing Remarks and Networking',
        speaker: 'Event Organizers Inc.',
        startTime: '15:30',
        endTime: '17:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
    ],
    images: [
      'https://content.jdmagicbox.com/comp/ernakulam/m4/0484px484.x484.140206113128.a9m4/catalogue/we-create-events-panampilly-nagar-ernakulam-event-management-companies-nsobpzm660.jpg',
      'https://content.jdmagicbox.com/comp/ernakulam/m4/0484px484.x484.140206113128.a9m4/catalogue/we-create-events-panampilly-nagar-ernakulam-event-management-companies-nsobpzm660.jpg',
    ],
    ticketsLeft: 100,
    category: 'Environment',
    totalCapacityNeeded: 150,
  ),
  Event(
    eventId: 'bc4b7b5c-e4eb-4e34-9005-0649e67b6883',
    title: 'Film Screening: International Cinema',
    date: DateTime(2025, 6, 18),
    time: '18:00 - 22:00',
    location: 'Cinema World',
    price: Price(regularPrice: 15.0, premiumPrice: 30.0),
    description: 'Experience a curated selection of international films from around the world. Join us for an evening of cinematic storytelling and cultural exploration.',
    organizer: dummyOrganizers[1],
    agenda: [
      AgendaItem(
        title: 'Welcome and Introduction',
        speaker: 'Film Festival Organizers',
        startTime: '18:00',
        endTime: '18:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      ),
      AgendaItem(
        title: 'Film Screening: Session 1',
        speaker: 'Featured Directors',
        startTime: '19:00',
        endTime: '20:30',
        speakerImageUrl: avatars[3],
      ),
      AgendaItem(
        title: 'Intermission and Networking',
        speaker: 'Film Festival Organizers',
        startTime: '20:30',
        endTime: '21:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/men/27.jpg',
      ),
      AgendaItem(
        title: 'Film Screening: Session 2',
        speaker: 'Featured Directors',
        startTime: '21:00',
        endTime: '22:30',
        speakerImageUrl: avatars[4],
      ),
    ],
    images: [
      'https://content.jdmagicbox.com/comp/ernakulam/m4/0484px484.x484.140206113128.a9m4/catalogue/we-create-events-panampilly-nagar-ernakulam-event-management-companies-nsobpzm660.jpg',
      'https://content.jdmagicbox.com/comp/ernakulam/m4/0484px484.x484.140206113128.a9m4/catalogue/we-create-events-panampilly-nagar-ernakulam-event-management-companies-nsobpzm660.jpg',
    ],
    ticketsLeft: 120,
    category: 'Film & Media',
    totalCapacityNeeded: 180,
  ),
  Event(
    eventId: 'c531d08b-1a9d-4b6e-908d-2d0b27f3518c',
    title: 'Sports Tournament: Soccer Challenge',
    date: DateTime(2025, 7, 5),
    time: '10:00 - 16:00',
    location: 'City Stadium',
    price: Price(regularPrice: 20.0, premiumPrice: 40.0),
    description: 'Cheer for your favorite teams in an action-packed soccer tournament. Watch skilled players compete for glory and enjoy a day of sportsmanship and excitement.',
    organizer: dummyOrganizers[0],
    agenda: [
      AgendaItem(
        title: 'Registration and Team Briefing',
        speaker: 'Event Organizers Inc.',
        startTime: '10:00',
        endTime: '10:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Soccer Tournament: Group Stage',
        speaker: 'Teams',
        startTime: '10:30',
        endTime: '13:00',
        speakerImageUrl: avatars[0],
      ),
      AgendaItem(
        title: 'Lunch Break',
        speaker: 'Event Organizers Inc.',
        startTime: '13:00',
        endTime: '14:00',
        speakerImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
      AgendaItem(
        title: 'Soccer Tournament: Knockout Stage',
        speaker: 'Teams',
        startTime: '14:00',
        endTime: '16:00',
        speakerImageUrl: avatars[1],
      ),
    ],
    images: [
      'https://static.vecteezy.com/system/resources/thumbnails/008/361/258/small/soccer-ball-on-abstract-gradient-background-illustration-vector.jpg',
      'https://static.vecteezy.com/system/resources/thumbnails/008/361/258/small/soccer-ball-on-abstract-gradient-background-illustration-vector.jpg',
    ],
    ticketsLeft: 160,
    category: 'Sports',
    totalCapacityNeeded: 200,
  ),
  Event(
    eventId: '2b7d1565-1940-4a1a-96f8-619a6671a5d2',
    title: 'Art Exhibition: Modern Masters',
    date: DateTime(2025, 8, 15),
    time: '11:00 - 19:00',
    location: 'Art Gallery',
    price: Price(regularPrice: 25.0, premiumPrice: 50.0),
    description: 'Discover contemporary art from renowned and emerging artists. Experience a diverse collection of paintings, sculptures, and multimedia installations.',
    organizer: dummyOrganizers[1],
    agenda: [
      AgendaItem(
        title: 'Welcome and Opening Reception',
        speaker: 'Art Gallery Curators',
        startTime: '11:00',
        endTime: '11:30',
        speakerImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      ),
      AgendaItem(
        title: 'Gallery Tour: Highlights of the Exhibition',
        speaker: 'Curators',
        startTime: '12:00',
        endTime: '14:00',
        speakerImageUrl: avatars[2],
      ),
      AgendaItem(
        title: 'Artist Talks and Q&A',
        speaker: 'Featured Artists',
        startTime: '14:00',
        endTime: '16:00',
        speakerImageUrl: avatars[3],
      ),
      AgendaItem(
        title: 'Closing Reception and Art Sales',
        speaker: 'Art Gallery Curators',
        startTime: '16:00',
        endTime: '19:00',
        speakerImageUrl: avatars[2],
      ),
    ],
    images: [
      'https://static.vecteezy.com/system/resources/previews/000/677/949/non_2x/liquid-gradient-color-background-fluid-gradient.jpg',
      'https://static.vecteezy.com/system/resources/previews/000/677/949/non_2x/liquid-gradient-color-background-fluid-gradient.jpg',
    ],
    ticketsLeft: 120,
    category: 'Art & Culture',
    totalCapacityNeeded: 180,
  ),
];


// List<UserAttendedEvent> dummyUserAttendedEvents = [
//   UserAttendedEvent(
//     userId: 'user1',
//     eventId: 'dbf789f1-ec6a-4a07-86a0-3b34f524a0fd',
//   ),
//   UserAttendedEvent(
//     userId: 'user2',
//     eventId: 'e31e47cc-1a4a-44e4-856b-832e2b4f4e11',
//   ),
//   UserAttendedEvent(
//     userId: 'user3',
//     eventId: 'e5a3a7e8-6f6e-4d99-95f0-5ff3e065c67f',
//   ),
//   UserAttendedEvent(
//     userId: 'user4',
//     eventId: '51c9a319-44b4-4216-ae5f-08c2ff5c3d44',
//   ),
//   UserAttendedEvent(
//     userId: 'user5',
//     eventId: '32f7e1e1-52af-4d56-89a1-1b62e789dd84',
//   ),
//   UserAttendedEvent(
//     userId: 'user1',
//     eventId: 'b8b31e9f-7b57-46a0-bbb8-553bb7c4ff7d',
//   ),
//   UserAttendedEvent(
//     userId: 'user2',
//     eventId: 'a931ac3e-9f20-4a08-b5a8-1a4429290f9a',
//   ),
//   UserAttendedEvent(
//     userId: 'user3',
//     eventId: 'e2c48e24-61c5-495f-a342-0023079fe8c4',
//   ),
//   UserAttendedEvent(
//     userId: 'user4',
//     eventId: 'a61c0e08-eb25-41f5-bb71-7df0db73f2e7',
//   ),
//   UserAttendedEvent(
//     userId: 'user5',
//     eventId: 'f60f578c-6a65-43ab-8e5f-34a6e93c7d6d',
//   ),
// ];

// List<EventReview> dummyEventReviews = [
//   EventReview(
//     userId: 'user1',
//     eventId: 'dbf789f1-ec6a-4a07-86a0-3b34f524a0fd',
//     rating: 4.5,
//     review: 'Great event with insightful discussions and excellent networking opportunities.',
//   ),
//   EventReview(
//     userId: 'user2',
//     eventId: 'e31e47cc-1a4a-44e4-856b-832e2b4f4e11',
//     rating: 5.0,
//     review: 'The art exhibition showcased amazing talent and creativity. A must-visit for art enthusiasts!',
//   ),
//   EventReview(
//     userId: 'user3',
//     eventId: 'e5a3a7e8-6f6e-4d99-95f0-5ff3e065c67f',
//     rating: 4.0,
//     review: 'The tech conference provided valuable insights into the future of technology.',
//   ),
//   EventReview(
//     userId: 'user4',
//     eventId: '51c9a319-44b4-4216-ae5f-08c2ff5c3d44',
//     rating: 4.0,
//     review: 'Startup Pitch Night was inspiring. Loved hearing the innovative ideas!',
//   ),
//   EventReview(
//     userId: 'user5',
//     eventId: '32f7e1e1-52af-4d56-89a1-1b62e789dd84',
//     rating: 4.5,
//     review: 'The music festival had a fantastic lineup and a great atmosphere.',
//   ),
//   EventReview(
//     userId: 'user1',
//     eventId: 'b8b31e9f-7b57-46a0-bbb8-553bb7c4ff7d',
//     rating: 4.0,
//     review: 'The fashion show showcased beautiful collections. A wonderful evening!',
//   ),
//   EventReview(
//     userId: 'user2',
//     eventId: 'a931ac3e-9f20-4a08-b5a8-1a4429290f9a',
//     rating: 4.5,
//     review: 'The food festival had delicious offerings and a vibrant atmosphere.',
//   ),
//   EventReview(
//     userId: 'user3',
//     eventId: 'e2c48e24-61c5-495f-a342-0023079fe8c4',
//     rating: 4.0,
//     review: 'The fitness expo provided great tips and activities for a healthier lifestyle.',
//   ),
//   EventReview(
//     userId: 'user4',
//     eventId: 'a61c0e08-eb25-41f5-bb71-7df0db73f2e7',
//     rating: 4.5,
//     review: 'The film festival showcased amazing films and insightful discussions.',
//   ),
//   EventReview(
//     userId: 'user5',
//     eventId: 'f60f578c-6a65-43ab-8e5f-34a6e93c7d6d',
//     rating: 4.0,
//     review: 'Gaming Expo was a blast! Enjoyed the tournaments and VR experiences.',
//   ),
// ];

// List<UserFavoriteEvent> dummyUserFavoriteEvents = [
//   UserFavoriteEvent(
//     userId: 'user1',
//     eventId: 'e5a3a7e8-6f6e-4d99-95f0-5ff3e065c67f',
//   ),
//   UserFavoriteEvent(
//     userId: 'user2',
//     eventId: 'b8b31e9f-7b57-46a0-bbb8-553bb7c4ff7d',
//   ),
//   UserFavoriteEvent(
//     userId: 'user3',
//     eventId: 'a931ac3e-9f20-4a08-b5a8-1a4429290f9a',
//   ),
//   UserFavoriteEvent(
//     userId: 'user4',
//     eventId: 'f60f578c-6a65-43ab-8e5f-34a6e93c7d6d',
//   ),
//   UserFavoriteEvent(
//     userId: 'user5',
//     eventId: '32f7e1e1-52af-4d56-89a1-1b62e789dd84',
//   ),
//   UserFavoriteEvent(
//     userId: 'user1',
//     eventId: '51c9a319-44b4-4216-ae5f-08c2ff5c3d44',
//   ),
//   UserFavoriteEvent(
//     userId: 'user2',
//     eventId: 'dbf789f1-ec6a-4a07-86a0-3b34f524a0fd',
//   ),
//   UserFavoriteEvent(
//     userId: 'user3',
//     eventId: 'e31e47cc-1a4a-44e4-856b-832e2b4f4e11',
//   ),
//   UserFavoriteEvent(
//     userId: 'user4',
//     eventId: 'a61c0e08-eb25-41f5-bb71-7df0db73f2e7',
//   ),
//   UserFavoriteEvent(
//     userId: 'user5',
//     eventId: 'e2c48e24-61c5-495f-a342-0023079fe8c4',
//   ),
// ];
