import 'models.dart';

final List<LearnArticle> learnArticles = [
  LearnArticle(
    id: 'a1',
    title: 'Wet vs. Dry: Know Your Waste',
    category: 'Segregation Basics',
    summary: 'Understanding the fundamental difference between wet and dry waste is the first step to effective household management.',
    content: 'Wet waste includes all biodegradable items: vegetable peels, fruit scraps, cooked food leftovers, tea/coffee grounds, and garden trimmings.\n\n'
             'Dry waste encompasses non-biodegradable materials that can still be recycled or must be sent to landfill — plastic wrappers, packaging, cardboard, glass bottles, and metal cans.\n\n'
             'The Key Rule: Keep them separate from the point of generation.\n\n'
             'Why is this important?\n\n'
             '1. Contamination: If wet waste mixes with dry waste, the dry waste (like paper or cardboard) becomes contaminated and cannot be recycled.\n'
             '2. Landfill Emissions: Wet waste in a landfill creates methane, a potent greenhouse gas. Proper segregation allows wet waste to be composted safely.\n'
             '3. Waste Worker Safety: Mixed waste creates unsanitary and hazardous conditions for sanitation workers.',
    icon: '🗑️',
    readTime: 4,
  ),
  LearnArticle(
    id: 'a2',
    title: 'The Plastic Problem at Home',
    category: 'Plastics',
    summary: 'Single-use plastics dominate household dry waste. Here\'s how to identify, reduce, and responsibly dispose of them.',
    content: 'Survey findings across urban households reveal that single-use plastics — bags, sachets, wrappers — constitute up to 40% of dry waste.\n\n'
             'Steps to Reduce Plastic Footprint:\n\n'
             '• Carry Cloth Bags: Always keep reusable bags in your vehicle or backpack.\n'
             '• Buy Local & Loose: Purchase unpackaged produce from local markets instead of heavily wrapped items from supermarkets.\n'
             '• Opt for Glass/Steel: Switch from plastic containers to durable, non-toxic alternatives for food storage.\n'
             '• Refuse Disposables: Say no to plastic cutlery, straws, and single-use cups when ordering out.\n\n'
             'Disposing Plastics Responsibly:\n\n'
             'When plastic usage is unavoidable, make sure to wash and dry the plastic before throwing it into the dry waste bin. Dirty plastics are instantly rejected by recycling facilities and diverted directly to landfills.',
    icon: '🔬',
    readTime: 5,
  ),
  LearnArticle(
    id: 'a3',
    title: 'Composting at Home',
    category: 'Wet Waste',
    summary: 'Transform kitchen scraps into nutrient-rich compost with a simple bin setup requiring just 10 minutes a week.',
    content: 'A basic compost bin only requires three key elements: a well-ventilated container, "brown" materials (carbon), and "green" materials (nitrogen).\n\n'
             'Browns: Dry leaves, shredded newspaper, cardboard, twigs.\n'
             'Greens: Vegetable/fruit peels, coffee grounds, tea leaves, grass clippings.\n\n'
             'How to start:\n\n'
             '1. Layer your bin starting with browns at the bottom for drainage.\n'
             '2. Add a layer of greens (kitchen scraps).\n'
             '3. Always cover latest greens with a top layer of browns to prevent flies and odors.\n'
             '4. Keep the pile moist (like a wrung-out sponge) and turn it over once a week to let oxygen flow.\n\n'
             'In 6-8 weeks, you will have black, earthy-smelling compost for your plants! Avoid adding meats, dairy, oils, or cooked food with heavy spices, as these attract pests and disrupt the composting process.',
    icon: '🌱',
    readTime: 6,
  ),
  LearnArticle(
    id: 'a4',
    title: 'Recycling Right: The Contamination Problem',
    category: 'Recycling',
    summary: 'Contaminated recyclables end up in landfills. Learn which materials are truly recyclable in Indian cities.',
    content: 'Recycling facilities operate under strict guidelines. If a batch of recyclables contains food residue, the entire batch may be deemed contaminated and destroyed.\n\n'
             'What IS Recyclable:\n\n'
             '• Clean PET bottles (Water/Soda bottles)\n'
             '• HDPE containers (Shampoo/Detergent bottles)\n'
             '• Dry cardboard and paper (Not pizza boxes with grease!)\n'
             '• Glass bottles and jars (Rinsed completely)\n'
             '• Aluminum and steel cans\n\n'
             'What is NOT Recyclable:\n\n'
             '• Soiled plastics and food containers with grease\n'
             '• Composite packaging (Chips packets, Tetra Paks, shiny wrappers - these are multi-layered)\n'
             '• Styrofoam\n'
             '• Broken glass or mirrors\n'
             '• Used tissues, napkins, or diapers\n\n'
             'The Golden Rule: When in doubt, throw it out (in the landfill waste bin) rather than risk contaminating a good recycling batch.',
    icon: '♻️',
    readTime: 5,
  ),
  LearnArticle(
    id: 'a5',
    title: 'SDGs and Your Household',
    category: 'Sustainability',
    summary: 'How your daily waste logging directly contributes to UN Sustainable Development Goals 11, 12, and 13.',
    content: 'The United Nations Sustainable Development Goals (SDGs) rely heavily on community action. By tracking and managing your household waste, you are contributing to:\n\n'
             'SDG 11: Sustainable Cities & Communities\n'
             'Proper waste management prevents urban flooding caused by clogged drains and reduces the financial burden of municipal solid waste infrastructure.\n\n'
             'SDG 12: Responsible Consumption & Production\n'
             'This goal aims to halve per capita global food waste at the retail and consumer levels. By logging and observing your waste, you naturally become more mindful of your purchasing habits, drastically reducing excess consumption.\n\n'
             'SDG 13: Climate Action\n'
             'Organic waste stuck in anaerobic (oxygen-less) landfills decomposes to generate methane, a greenhouse gas 25 times more potent than CO₂ at trapping heat. Composting at home directly fights global warming.',
    icon: '🌍',
    readTime: 4,
  ),
  LearnArticle(
    id: 'a6',
    title: 'Understanding Your Waste Analytics',
    category: 'App Guide',
    summary: 'Make the most of Ciclo\'s analytics — learn what each chart and metric means for your household.',
    content: 'Ciclo Waste Intelligence translates your daily habits into actionable metrics.\n\n'
             'Composition Pie Chart:\n\n'
             'This shows the percentage split between your Wet, Dry, and Recyclable waste. \n'
             'Target Goals:\n'
             '- Wet Waste: Can be high, but 100% of it should ideally be diverted to composting.\n'
             '- Dry Waste: Aim for less than 20% of your total footprint. This represents your sheer landfill-bound trash.\n'
             '- Recyclable: Aim to maximize this ratio compared to non-recyclable dry waste.\n\n'
             'Weekly Trend Chart:\n\n'
             'Observe spikes in generation. Does your waste spike on weekends? Identify the cause (party, takeout, cleaning) and formulate a plan to mitigate wrapped purchases during those days.\n\n'
             'Per Capita Metric:\n\n'
             'This compares your household\'s generation against standard averages. Strive to stay below 0.5kg per person per day to operate a truly low-waste home.',
    icon: '📊',
    readTime: 5,
  ),
];
