import 'package:flutter/material.dart';

void main()=>runApp(const FayPortfolio());

class FayPortfolio extends StatelessWidget{
  const FayPortfolio({super.key});
  @override
  Widget build(BuildContext c)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    title:'Fay Al-Mutairi | Portfolio',
    theme:ThemeData(
      useMaterial3:true,
      scaffoldBackgroundColor:const Color(0xFFF4EFE7),
      colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF171717)),
    ),
    home:const PortfolioPage(),
  );
}

class PortfolioPage extends StatefulWidget{
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState()=>_PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>{
  final about=GlobalKey(),training=GlobalKey(),projects=GlobalKey(),skills=GlobalKey(),contact=GlobalKey();

  void go(GlobalKey k){
    final c=k.currentContext;
    if(c!=null)Scrollable.ensureVisible(c,duration:const Duration(milliseconds:520),curve:Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext c){
    final mobile=MediaQuery.sizeOf(c).width<760;
    return Scaffold(
      body:CustomScrollView(
        slivers:[
          SliverAppBar(
            pinned:true,
            backgroundColor:const Color(0xFFF4EFE7),
            surfaceTintColor:Colors.transparent,
            title:const Text('FAY AL-MUTAIRI',style:TextStyle(fontWeight:FontWeight.w800,fontSize:15,letterSpacing:1.5)),
            actions:mobile
                ? [
                    PopupMenuButton<String>(
                      icon:const Icon(Icons.menu_rounded),
                      color:const Color(0xFFF4EFE7),
                      onSelected:(v){
                        if(v=='about')go(about);
                        if(v=='training')go(training);
                        if(v=='projects')go(projects);
                        if(v=='skills')go(skills);
                        if(v=='contact')go(contact);
                      },
                      itemBuilder:(c)=>const [
                        PopupMenuItem(value:'about',child:Row(children:[Icon(Icons.person_outline,size:18),SizedBox(width:10),Text('About')])),
                        PopupMenuItem(value:'training',child:Row(children:[Icon(Icons.work_outline,size:18),SizedBox(width:10),Text('Training')])),
                        PopupMenuItem(value:'projects',child:Row(children:[Icon(Icons.grid_view_rounded,size:18),SizedBox(width:10),Text('Projects')])),
                        PopupMenuItem(value:'skills',child:Row(children:[Icon(Icons.auto_awesome_outlined,size:18),SizedBox(width:10),Text('Skills')])),
                        PopupMenuItem(value:'contact',child:Row(children:[Icon(Icons.mail_outline,size:18),SizedBox(width:10),Text('Contact')])),
                      ],
                    ),
                    const SizedBox(width:8),
                  ]
                : [
                    _Nav('About',()=>go(about)),
                    _Nav('Training',()=>go(training)),
                    _Nav('Projects',()=>go(projects)),
                    _Nav('Skills',()=>go(skills)),
                    _Nav('Contact',()=>go(contact)),
                    const SizedBox(width:16),
                  ],
          ),
          SliverToBoxAdapter(
            child:Center(
              child:ConstrainedBox(
                constraints:const BoxConstraints(maxWidth:1160),
                child:Padding(
                  padding:const EdgeInsets.symmetric(horizontal:24),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      const SizedBox(height:70),
                      _Reveal(delay:0,child:_Hero(onWork:()=>go(projects))),
                      const SizedBox(height:100),
                      _Reveal(delay:80,child:_Section(key:about,n:'01',title:'About',icon:Icons.person_outline,child:const _About())),
                      _Reveal(delay:120,child:_Section(key:training,n:'02',title:'Training',icon:Icons.work_outline,child:const _Training())),
                      _Reveal(delay:160,child:_Section(key:projects,n:'03',title:'Projects',icon:Icons.grid_view_rounded,child:const _Projects())),
                      _Reveal(delay:200,child:_Section(key:skills,n:'04',title:'Skills',icon:Icons.auto_awesome_outlined,child:const _Skills())),
                      _Reveal(delay:240,child:_Section(key:contact,n:'05',title:'Contact',icon:Icons.mail_outline,child:const _Contact())),
                      const Divider(),
                      const Padding(padding:EdgeInsets.symmetric(vertical:26),child:Text('Fay Al-Mutairi  •  Information Technology  •  Saudi Arabia')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Reveal extends StatefulWidget{
  final Widget child;
  final int delay;
  const _Reveal({required this.child,required this.delay});
  @override State<_Reveal> createState()=>_RevealState();
}
class _RevealState extends State<_Reveal> with SingleTickerProviderStateMixin{
  late final AnimationController controller;
  late final Animation<double> fade;
  late final Animation<Offset> slide;
  @override void initState(){
    super.initState();
    controller=AnimationController(vsync:this,duration:const Duration(milliseconds:650));
    fade=CurvedAnimation(parent:controller,curve:Curves.easeOut);
    slide=Tween<Offset>(begin:const Offset(0,.055),end:Offset.zero).animate(CurvedAnimation(parent:controller,curve:Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds:widget.delay),(){if(mounted)controller.forward();});
  }
  @override void dispose(){controller.dispose();super.dispose();}
  @override Widget build(BuildContext c)=>FadeTransition(opacity:fade,child:SlideTransition(position:slide,child:widget.child));
}

class _Nav extends StatelessWidget{final String t;final VoidCallback f;const _Nav(this.t,this.f);@override Widget build(BuildContext c)=>TextButton(onPressed:f,child:Text(t,style:const TextStyle(color:Color(0xFF171717),fontWeight:FontWeight.w600)));}

class _Hero extends StatelessWidget{
  final VoidCallback onWork;
  const _Hero({required this.onWork});
  @override
  Widget build(BuildContext c)=>LayoutBuilder(builder:(c,x){
    final s=x.maxWidth<780;
    final text=Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const Row(children:[Icon(Icons.code_rounded,size:16),SizedBox(width:8),Text('INFORMATION TECHNOLOGY',style:TextStyle(fontSize:12,fontWeight:FontWeight.w700,letterSpacing:2.2))]),
      const SizedBox(height:18),
      FittedBox(fit:BoxFit.scaleDown,alignment:Alignment.centerLeft,child:Text('Fay Al-Mutairi',maxLines:1,style:TextStyle(fontSize:s?54:76,height:.98,fontWeight:FontWeight.w900,letterSpacing:-2.2))),
      const SizedBox(height:24),
      const Text('IT graduate focused on data analytics, Flutter development and practical AI. My work combines hands-on training with projects built around real interfaces, datasets, APIs and software solutions.',style:TextStyle(fontSize:18,height:1.6,color:Color(0xFF504A43))),
      const SizedBox(height:28),
      FilledButton.icon(onPressed:onWork,icon:const Icon(Icons.arrow_downward_rounded,size:18),label:const Text('View my work'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFF171717),padding:const EdgeInsets.symmetric(horizontal:24,vertical:17),shape:const RoundedRectangleBorder())),
    ]);
    final image=Container(height:s?350:480,decoration:BoxDecoration(border:Border.all(color:const Color(0xFF171717))),child:Image.asset('assets/IMG_6645.PNG',fit:BoxFit.cover));
    return s?Column(crossAxisAlignment:CrossAxisAlignment.start,children:[text,const SizedBox(height:38),image]):Row(children:[Expanded(flex:6,child:text),const SizedBox(width:55),Expanded(flex:4,child:image)]);
  });
}

class _Section extends StatelessWidget{
  final String n,title;
  final IconData icon;
  final Widget child;
  const _Section({super.key,required this.n,required this.title,required this.icon,required this.child});
  @override Widget build(BuildContext c)=>Padding(
    padding:const EdgeInsets.only(bottom:95),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const Divider(),
      const SizedBox(height:16),
      Row(children:[
        Container(width:42,height:42,decoration:BoxDecoration(color:const Color(0xFF171717),borderRadius:BorderRadius.circular(12)),child:Icon(icon,color:Colors.white,size:21)),
        const SizedBox(width:14),
        Text('$n   $title',style:const TextStyle(fontSize:34,fontWeight:FontWeight.w900,letterSpacing:-1)),
      ]),
      const SizedBox(height:38),
      child,
    ]),
  );
}

class _About extends StatelessWidget{const _About();@override Widget build(BuildContext c)=>const Text('I am an Information Technology graduate from Qassim University with hands-on experience across data analytics and application development. My portfolio reflects the same areas I trained in: building dashboards and working with data, developing Flutter applications, using Firebase and databases, integrating APIs, and exploring AI through my graduation project. I focus on practical, clear solutions and clean user experiences.',style:TextStyle(fontSize:20,height:1.7,fontWeight:FontWeight.w500));}

class _Training extends StatelessWidget{const _Training();@override Widget build(BuildContext c)=>const Column(children:[_TrainingCard(title:'Data Analysis Intern',place:'Al Qassim Municipality • Data Management & Statistics Office',period:'June – August 2025',body:'Completed an 8-week cooperative training program in a government data environment. Worked on cleaning and validating 750+ municipal records, reviewing data quality and inconsistencies, and supporting KPI reporting. Built analytical dashboards with Power BI and Excel for quarterly comparisons and clearer decision-support reporting. Internal datasets and work samples are not displayed because the training was completed within a government entity.',tags:['Power BI','Excel','Data Cleaning','Data Validation','KPI Reporting','Data Visualization'],image:'assets/projects/training.png'),_TrainingCard(title:'Application Development Intern',place:'Kharja • Startup',period:'February – May 2024',body:'Worked in application development using Flutter and Dart, with Firebase for authentication, database and backend-connected services. The training strengthened my understanding of UI/UX implementation, mobile application structure, software-development workflow and turning interface concepts into functional application screens.',tags:['Flutter','Dart','Firebase','UI/UX','Mobile Development','Git'])]);}
class _TrainingCard extends StatelessWidget{final String title,place,period,body;final List<String> tags;final String? image;const _TrainingCard({required this.title,required this.place,required this.period,required this.body,required this.tags,this.image});@override Widget build(BuildContext c)=>Container(width:double.infinity,padding:const EdgeInsets.symmetric(vertical:30),decoration:const BoxDecoration(border:Border(bottom:BorderSide(color:Color(0xFFBDB4A8)))),child:LayoutBuilder(builder:(c,x){final compact=x.maxWidth<760;final text=Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w800)),const SizedBox(height:6),Text(place,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w700)),Text(period,style:const TextStyle(color:Color(0xFF6C655D))),const SizedBox(height:16),Text(body,style:const TextStyle(fontSize:16,height:1.65,color:Color(0xFF4E4943))),const SizedBox(height:16),Wrap(spacing:8,runSpacing:8,children:tags.map((e)=>_Tag(e)).toList())]);if(image==null)return text;final cert=Container(height:compact?170:190,width:double.infinity,padding:const EdgeInsets.all(10),color:Colors.white,child:Image.asset(image!,fit:BoxFit.contain));return compact?Column(crossAxisAlignment:CrossAxisAlignment.start,children:[text,const SizedBox(height:20),cert]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:7,child:text),const SizedBox(width:28),Expanded(flex:3,child:cert)]);}));}

class _Projects extends StatefulWidget{const _Projects();@override State<_Projects> createState()=>_ProjectsState();}
class _ProjectsState extends State<_Projects>{
  String filter='All';
  static const items=[
    _Project('Anees','AI','Graduation Project','A wellbeing application and AI-focused graduation project designed around emotion understanding and supportive user experiences. The interfaces include mood check-ins, habit tracking, breathing exercises, community support, and interaction through voice or camera. The AI work explored multimodal emotion recognition using audio, facial and video inputs and datasets including RAVDESS and MELD.',['AI','Deep Learning','Flutter','Emotion Recognition'],['assets/projects/anees-1.png','assets/projects/anees-2.png','assets/projects/anees-3.png','assets/projects/anees-4.png','assets/projects/anees-5.png']),
    _Project('Weather Dashboard','Data Analytics','API • Dashboard','A weather dashboard connected to an API and refreshed periodically. It presents current conditions, multi-day forecasts, humidity, wind speed, visibility, pressure, UV index, precipitation, sunrise/sunset and air-quality indicators in one visual view.',['API','Dashboard','Data Visualization'],['assets/projects/weather.jpg']),
    _Project('Sales Dashboard','Data Analytics','Business Analytics','A clean sales dashboard created to demonstrate analysis and visualization skills through KPIs, sales and revenue comparisons, customers, product performance, trends and weekly category views.',['Power BI','KPIs','Sales Analytics'],['assets/projects/sales.jpg']),
    _Project('COVID-19 Dashboard','Data Analytics','Tableau • Large Dataset','Built from a large COVID-19 dataset in Tableau to explore deaths by continent, population infection percentages, country comparisons, geographic distribution and overall cases and deaths.',['Tableau','Large Dataset','Analytics'],['assets/projects/covid.png']),
    _Project('Real Estate App','Flutter & Mobile','Flutter','A simple real-estate mobile application with property browsing, search and filters. Users can browse houses, villas and apartments and narrow listings through a straightforward mobile interface.',['Flutter','Mobile','Filters'],['assets/projects/realestate-1.png','assets/projects/realestate-2.png']),
    _Project('Graduation Projects Platform','Flutter & Mobile','Flutter Web','A Flutter Web platform created as a dedicated space for students to showcase graduation projects. Students submit their projects through a structured form, making project sharing and discovery more organized.',['Flutter Web','Forms','UI/UX'],['assets/projects/gradplatform.png']),
    _Project('Kharja','Flutter & Mobile','Mobile Application','A mobile application project developed around planning outings and nearby activities. The interface includes creating a new outing, adding a cover image, title and description, and selecting categories such as sports, food, music, gaming, arts and culture.',['Flutter','Mobile Development','UI/UX'],['assets/projects/kharja-1.png','assets/projects/kharja-2.png']),
    _Project('Library Database Schema','Web & Database','Database Design','A database-design project for a university library system focused on entities, relationships and organized information structure.',['Database Design','SQL','Data Modeling'],[]),
  ];
  @override Widget build(BuildContext c){
    const filters=['All','Data Analytics','Flutter & Mobile','AI','Web & Database'];
    final shown=filter=='All'?items:items.where((e)=>e.category==filter).toList();
    return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const Text('Browse by area. Open a project to see the full description, skills and images.',style:TextStyle(fontSize:16,height:1.6,color:Color(0xFF5A544D))),
      const SizedBox(height:18),
      Wrap(spacing:9,runSpacing:9,children:filters.map((e)=>ChoiceChip(label:Text(e),selected:filter==e,onSelected:(_)=>setState(()=>filter=e),selectedColor:const Color(0xFF171717),labelStyle:TextStyle(color:filter==e?Colors.white:const Color(0xFF171717)))).toList()),
      const SizedBox(height:30),
      LayoutBuilder(builder:(c,x){final w=x.maxWidth<700?x.maxWidth:(x.maxWidth-20)/2;return Wrap(spacing:20,runSpacing:20,children:shown.asMap().entries.map((entry)=>SizedBox(width:w,child:_HoverLift(child:_ProjectCard(entry.value)))).toList());}),
    ]);
  }
}

class _HoverLift extends StatefulWidget{final Widget child;const _HoverLift({required this.child});@override State<_HoverLift> createState()=>_HoverLiftState();}
class _HoverLiftState extends State<_HoverLift>{bool hover=false;@override Widget build(BuildContext c)=>MouseRegion(onEnter:(_)=>setState(()=>hover=true),onExit:(_)=>setState(()=>hover=false),child:AnimatedContainer(duration:const Duration(milliseconds:180),transform:Matrix4.translationValues(0,hover?-6:0,0),decoration:BoxDecoration(boxShadow:hover?const [BoxShadow(color:Color(0x18000000),blurRadius:24,offset:Offset(0,12))]:const []),child:widget.child));}

class _Project{final String title,category,type,description;final List<String> tags,images;const _Project(this.title,this.category,this.type,this.description,this.tags,this.images);}
class _ProjectCard extends StatelessWidget{final _Project p;const _ProjectCard(this.p);@override Widget build(BuildContext c){final cover=p.images.isNotEmpty?p.images.first:null;return Material(color:const Color(0xFFE9E1D6),child:InkWell(onTap:()=>Navigator.of(c).push(MaterialPageRoute(builder:(_)=>_ProjectDetails(p))),child:Container(decoration:BoxDecoration(border:Border.all(color:const Color(0xFFBDB4A8))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[if(cover!=null)Container(height:185,width:double.infinity,color:const Color(0xFFF8F5F0),padding:const EdgeInsets.all(14),child:Image.asset(cover,fit:BoxFit.contain)),Padding(padding:const EdgeInsets.all(22),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[const Icon(Icons.folder_open_outlined,size:16),const SizedBox(width:7),Text(p.category.toUpperCase(),style:const TextStyle(fontSize:11,fontWeight:FontWeight.w800,letterSpacing:1.4))]),const SizedBox(height:12),Text(p.title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:6),Text(p.type,style:const TextStyle(color:Color(0xFF6C655D),fontWeight:FontWeight.w700)),const SizedBox(height:16),const Row(children:[Text('View project',style:TextStyle(fontWeight:FontWeight.w700)),SizedBox(width:6),Icon(Icons.arrow_forward,size:17)])]))])))));}}

class _ProjectDetails extends StatefulWidget{final _Project p;const _ProjectDetails(this.p);@override State<_ProjectDetails> createState()=>_ProjectDetailsState();}
class _ProjectDetailsState extends State<_ProjectDetails>{late final PageController pc;int current=0;@override void initState(){super.initState();pc=PageController(viewportFraction:.7);}@override void dispose(){pc.dispose();super.dispose();}@override Widget build(BuildContext c){final p=widget.p;final phone=p.images.length>1&&(p.title=='Anees'||p.title=='Real Estate App'||p.title=='Kharja');return Scaffold(backgroundColor:const Color(0xFFF4EFE7),appBar:AppBar(backgroundColor:const Color(0xFFF4EFE7),surfaceTintColor:Colors.transparent,title:Text(p.title,style:const TextStyle(fontWeight:FontWeight.w800))),body:SingleChildScrollView(child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1040),child:Padding(padding:const EdgeInsets.fromLTRB(24,36,24,70),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(p.category.toUpperCase(),style:const TextStyle(fontSize:12,fontWeight:FontWeight.w800,letterSpacing:1.8)),const SizedBox(height:12),Text(p.title,style:const TextStyle(fontSize:48,height:1,fontWeight:FontWeight.w900,letterSpacing:-1.5)),const SizedBox(height:10),Text(p.type,style:const TextStyle(fontSize:17,color:Color(0xFF6C655D),fontWeight:FontWeight.w700)),const SizedBox(height:28),Text(p.description,style:const TextStyle(fontSize:18,height:1.75,color:Color(0xFF413C36))),const SizedBox(height:24),Wrap(spacing:8,runSpacing:8,children:p.tags.map((e)=>_Tag(e)).toList()),if(p.images.isNotEmpty)...[const SizedBox(height:42),const Divider(),const SizedBox(height:22),const Text('Project Gallery',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:18),phone?_PhoneCarousel(images:p.images,controller:pc,current:current,onChanged:(i)=>setState(()=>current=i)):_DetailsGallery(p.images)]]))))));}}
class _PhoneCarousel extends StatelessWidget{final List<String> images;final PageController controller;final int current;final ValueChanged<int> onChanged;const _PhoneCarousel({required this.images,required this.controller,required this.current,required this.onChanged});@override Widget build(BuildContext c)=>Column(children:[SizedBox(height:520,child:PageView.builder(controller:controller,itemCount:images.length,onPageChanged:onChanged,physics:const BouncingScrollPhysics(),itemBuilder:(c,i){final active=i==current;return AnimatedScale(scale:active?1:.88,duration:const Duration(milliseconds:260),curve:Curves.easeOut,child:AnimatedOpacity(opacity:active?1:.55,duration:const Duration(milliseconds:260),child:Center(child:_PhoneFrame(image:images[i]))));})),const SizedBox(height:14),Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(images.length,(i){final active=i==current;return AnimatedContainer(duration:const Duration(milliseconds:220),margin:const EdgeInsets.symmetric(horizontal:4),width:active?24:7,height:7,decoration:BoxDecoration(color:active?const Color(0xFF171717):const Color(0xFFBDB4A8),borderRadius:BorderRadius.circular(20)));}))]);}
class _PhoneFrame extends StatelessWidget{final String image;const _PhoneFrame({required this.image});@override Widget build(BuildContext c)=>Container(width:245,height:500,padding:const EdgeInsets.all(9),decoration:BoxDecoration(color:const Color(0xFF151515),borderRadius:BorderRadius.circular(34),boxShadow:const [BoxShadow(blurRadius:22,offset:Offset(0,12),color:Color(0x22000000))]),child:Stack(children:[ClipRRect(borderRadius:BorderRadius.circular(26),child:Container(color:Colors.white,width:double.infinity,height:double.infinity,child:Image.asset(image,fit:BoxFit.contain))),Align(alignment:Alignment.topCenter,child:Container(width:78,height:18,margin:const EdgeInsets.only(top:7),decoration:BoxDecoration(color:const Color(0xFF151515),borderRadius:BorderRadius.circular(14))))]));}
class _DetailsGallery extends StatelessWidget{final List<String> images;const _DetailsGallery(this.images);@override Widget build(BuildContext c)=>LayoutBuilder(builder:(c,x){if(images.length==1)return Center(child:ConstrainedBox(constraints:const BoxConstraints(maxHeight:520,maxWidth:900),child:Container(width:double.infinity,padding:const EdgeInsets.all(16),color:Colors.white,child:Image.asset(images.first,fit:BoxFit.contain))));final mobile=x.maxWidth<700;final w=mobile?x.maxWidth:(x.maxWidth-16)/2;return Wrap(spacing:16,runSpacing:16,children:images.map((img)=>Container(width:w,height:300,padding:const EdgeInsets.all(14),color:Colors.white,child:Image.asset(img,fit:BoxFit.contain))).toList());});}
class _Tag extends StatelessWidget{final String t;const _Tag(this.t);@override Widget build(BuildContext c)=>Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:6),decoration:BoxDecoration(border:Border.all(color:const Color(0xFF8E857A))),child:Text(t,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w600)));}
class _Skills extends StatelessWidget{const _Skills();@override Widget build(BuildContext c)=>const Wrap(spacing:45,runSpacing:35,children:[_Skill('Data Analytics',['Power BI','Tableau','Excel','Python','SQL','Data Cleaning','KPI Reporting'],Icons.insights_outlined),_Skill('Development',['Flutter','Flutter Web','Dart','Firebase','Git','APIs'],Icons.devices_outlined),_Skill('AI & Database',['Machine Learning','Deep Learning','Emotion Recognition','Database Design','Data Modeling'],Icons.memory_outlined)]);}
class _Skill extends StatelessWidget{final String t;final List<String> x;final IconData icon;const _Skill(this.t,this.x,this.icon);@override Widget build(BuildContext c)=>SizedBox(width:300,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:40,height:40,decoration:BoxDecoration(border:Border.all(color:const Color(0xFF171717)),borderRadius:BorderRadius.circular(10)),child:Icon(icon,size:20)),const SizedBox(height:14),Text(t,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:12),Text(x.join('  •  '),style:const TextStyle(fontSize:15,height:1.8,color:Color(0xFF4E4943)))]));}
class _Contact extends StatelessWidget{const _Contact();@override Widget build(BuildContext c)=>const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Open to opportunities in data analytics, application development and practical technology projects.',style:TextStyle(fontSize:25,height:1.45,fontWeight:FontWeight.w800)),SizedBox(height:28),_ContactLine(Icons.phone_outlined,'Phone','0530460609'),_ContactLine(Icons.mail_outline,'Email','fayalmtuairi@gmail.com'),_ContactLine(Icons.code_outlined,'GitHub','github.com/FayAL-mtuairi'),_ContactLine(Icons.link_outlined,'LinkedIn','linkedin.com/in/fay-al-mutairi-834a4a246')]);}
class _ContactLine extends StatelessWidget{final IconData icon;final String a,b;const _ContactLine(this.icon,this.a,this.b);@override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.symmetric(vertical:9),child:Wrap(crossAxisAlignment:WrapCrossAlignment.center,spacing:12,children:[Icon(icon,size:18),SizedBox(width:85,child:Text(a,style:const TextStyle(fontWeight:FontWeight.w800))),SelectableText(b)]));}
