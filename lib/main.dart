import 'package:flutter/material.dart';

void main() => runApp(const FayPortfolio());

class FayPortfolio extends StatelessWidget {
  const FayPortfolio({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Fay Al-Mutairi | Portfolio',
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: const Color(0xFFF4EFE7), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF171717))),
    home: const PortfolioPage(),
  );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override State<PortfolioPage> createState()=>_PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>{
  final about=GlobalKey(),training=GlobalKey(),projects=GlobalKey(),skills=GlobalKey(),contact=GlobalKey();
  void go(GlobalKey k){final c=k.currentContext;if(c!=null)Scrollable.ensureVisible(c,duration:const Duration(milliseconds:450),curve:Curves.easeOut);}
  @override Widget build(BuildContext context){
    final mobile=MediaQuery.sizeOf(context).width<760;
    return Scaffold(body:CustomScrollView(slivers:[
      SliverAppBar(pinned:true,backgroundColor:const Color(0xFFF4EFE7),title:const Text('FAY AL-MUTAIRI',style:TextStyle(fontWeight:FontWeight.w800,fontSize:15,letterSpacing:1.5)),actions:mobile?null:[_Nav('About',()=>go(about)),_Nav('Training',()=>go(training)),_Nav('Projects',()=>go(projects)),_Nav('Skills',()=>go(skills)),_Nav('Contact',()=>go(contact)),const SizedBox(width:16)]),
      SliverToBoxAdapter(child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1160),child:Padding(padding:const EdgeInsets.symmetric(horizontal:24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const SizedBox(height:70),_Hero(onWork:()=>go(projects)),const SizedBox(height:100),
        _Section(key:about,n:'01',title:'About',child:const _About()),
        _Section(key:training,n:'02',title:'Training',child:const _Training()),
        _Section(key:projects,n:'03',title:'Projects',child:const _Projects()),
        _Section(key:skills,n:'04',title:'Skills',child:const _Skills()),
        _Section(key:contact,n:'05',title:'Contact',child:const _Contact()),
        const Divider(),const Padding(padding:EdgeInsets.symmetric(vertical:26),child:Text('Fay Al-Mutairi  •  Information Technology  •  Saudi Arabia'))
      ]))))
    ]));
  }
}

class _Nav extends StatelessWidget{final String t;final VoidCallback f;const _Nav(this.t,this.f);@override Widget build(BuildContext c)=>TextButton(onPressed:f,child:Text(t,style:const TextStyle(color:Color(0xFF171717),fontWeight:FontWeight.w600)));}

class _Hero extends StatelessWidget{final VoidCallback onWork;const _Hero({required this.onWork});@override Widget build(BuildContext c)=>LayoutBuilder(builder:(c,x){final s=x.maxWidth<780;final text=Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('INFORMATION TECHNOLOGY',style:TextStyle(fontSize:12,fontWeight:FontWeight.w700,letterSpacing:2.2)),const SizedBox(height:18),Text('Fay\nAl-Mutairi',style:TextStyle(fontSize:s?56:84,height:.94,fontWeight:FontWeight.w900,letterSpacing:-2.5)),const SizedBox(height:24),const Text('IT graduate focused on data analytics, Flutter development and practical AI. My work combines hands-on training with projects built around real interfaces, datasets, APIs and software solutions.',style:TextStyle(fontSize:18,height:1.6,color:Color(0xFF504A43))),const SizedBox(height:28),FilledButton(onPressed:onWork,style:FilledButton.styleFrom(backgroundColor:const Color(0xFF171717),padding:const EdgeInsets.symmetric(horizontal:24,vertical:17),shape:const RoundedRectangleBorder()),child:const Text('View my work'))]);final image=Container(height:s?350:480,decoration:BoxDecoration(border:Border.all(color:const Color(0xFF171717))),child:Image.asset('assets/IMG_6645.PNG',fit:BoxFit.cover));return s?Column(crossAxisAlignment:CrossAxisAlignment.start,children:[text,const SizedBox(height:38),image]):Row(children:[Expanded(flex:6,child:text),const SizedBox(width:55),Expanded(flex:4,child:image)]);});}

class _Section extends StatelessWidget{final String n,title;final Widget child;const _Section({super.key,required this.n,required this.title,required this.child});@override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.only(bottom:95),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Divider(),const SizedBox(height:16),Text('$n   $title',style:const TextStyle(fontSize:34,fontWeight:FontWeight.w900,letterSpacing:-1)),const SizedBox(height:38),child]));}

class _About extends StatelessWidget{const _About();@override Widget build(BuildContext c)=>const Text('I am an Information Technology graduate from Qassim University with hands-on experience across data analytics and application development. My portfolio reflects the same areas I trained in: building dashboards and working with data, developing Flutter applications, using Firebase and databases, integrating APIs, and exploring AI through my graduation project. I focus on practical, clear solutions and clean user experiences.',style:TextStyle(fontSize:20,height:1.7,fontWeight:FontWeight.w500));}

class _Training extends StatelessWidget{const _Training();@override Widget build(BuildContext c)=>const Column(children:[
  _TrainingCard(title:'Data Analysis Intern',place:'Al Qassim Municipality • Data Management & Statistics Office',period:'June – August 2025',body:'Completed an 8-week cooperative training program in a government data environment. Worked on cleaning and validating 750+ municipal records, reviewing data quality and inconsistencies, and supporting KPI reporting. Built analytical dashboards with Power BI and Excel for quarterly comparisons and clearer decision-support reporting. Internal datasets and work samples are not displayed because the training was completed within a government entity.',tags:['Power BI','Excel','Data Cleaning','Data Validation','KPI Reporting','Data Visualization']),
  _TrainingCard(title:'Application Development Intern',place:'Kharja • Startup',period:'February – May 2024',body:'Worked in application development using Flutter and Dart, with Firebase for authentication, database and backend-connected services. The training strengthened my understanding of UI/UX implementation, mobile application structure, software-development workflow and turning interface concepts into functional application screens.',tags:['Flutter','Dart','Firebase','UI/UX','Mobile Development','Git'])
]);}
class _TrainingCard extends StatelessWidget{final String title,place,period,body;final List<String> tags;const _TrainingCard({required this.title,required this.place,required this.period,required this.body,required this.tags});@override Widget build(BuildContext c)=>Container(width:double.infinity,padding:const EdgeInsets.symmetric(vertical:28),decoration:const BoxDecoration(border:Border(bottom:BorderSide(color:Color(0xFFBDB4A8)))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w800)),const SizedBox(height:6),Text(place,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w700)),Text(period,style:const TextStyle(color:Color(0xFF6C655D))),const SizedBox(height:16),Text(body,style:const TextStyle(fontSize:16,height:1.7,color:Color(0xFF4E4943))),const SizedBox(height:16),Wrap(spacing:8,runSpacing:8,children:tags.map((e)=>_Tag(e)).toList())]));}

class _Projects extends StatefulWidget{const _Projects();@override State<_Projects> createState()=>_ProjectsState();}
class _ProjectsState extends State<_Projects>{String filter='All';static const items=[
_Project('Anees','AI','Graduation Project','A wellbeing application and AI-focused graduation project designed around emotion understanding and supportive user experiences. The interfaces include mood check-ins, habit tracking, breathing exercises, community support, and interaction through voice or camera. The AI work explored multimodal emotion recognition using audio, facial and video inputs and datasets including RAVDESS and MELD.',['AI','Deep Learning','Flutter','Emotion Recognition']),
_Project('Weather Dashboard','Data Analytics','API • Dashboard','A weather dashboard connected to an API and refreshed periodically. It presents current conditions, multi-day forecasts, humidity, wind speed, visibility, pressure, UV index, precipitation, sunrise/sunset and air-quality indicators in one visual view.',['API','Dashboard','Data Visualization']),
_Project('Sales Dashboard','Data Analytics','Business Analytics','A clean sales dashboard created to demonstrate analysis and visualization skills through KPIs, sales and revenue comparisons, customers, product performance, trends and weekly category views.',['Power BI','KPIs','Sales Analytics']),
_Project('COVID-19 Dashboard','Data Analytics','Tableau • Large Dataset','Built from a large COVID-19 dataset in Tableau to explore deaths by continent, population infection percentages, country comparisons, geographic distribution and overall cases and deaths.',['Tableau','Large Dataset','Analytics']),
_Project('Real Estate App','Flutter & Mobile','Flutter','A simple real-estate mobile application with property browsing, search and filters. Users can browse houses, villas and apartments and narrow listings through a straightforward mobile interface.',['Flutter','Mobile','Filters']),
_Project('Graduation Projects Platform','Flutter & Mobile','Flutter Web','A Flutter Web platform created as a dedicated space for students to showcase graduation projects. Students submit their projects through a structured form, making project sharing and discovery more organized.',['Flutter Web','Forms','UI/UX']),
_Project('Kharja','Flutter & Mobile','Mobile Application','A mobile application project developed around planning outings and nearby activities. The interface includes creating a new outing, adding a cover image, title and description, and selecting categories such as sports, food, music, gaming, arts and culture.',['Flutter','Mobile Development','UI/UX']),
_Project('Library Database Schema','Web & Database','Database Design','A database-design project for a university library system focused on entities, relationships and organized information structure.',['Database Design','SQL','Data Modeling'])];
@override Widget build(BuildContext c){const filters=['All','Data Analytics','Flutter & Mobile','AI','Web & Database'];final shown=filter=='All'?items:items.where((e)=>e.category==filter).toList();return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('The filters mirror the areas I trained in and the projects I built within each area.',style:TextStyle(fontSize:16,height:1.6,color:Color(0xFF5A544D))),const SizedBox(height:18),Wrap(spacing:9,runSpacing:9,children:filters.map((e)=>ChoiceChip(label:Text(e),selected:filter==e,onSelected:(_)=>setState(()=>filter=e),selectedColor:const Color(0xFF171717),labelStyle:TextStyle(color:filter==e?Colors.white:const Color(0xFF171717)))).toList()),const SizedBox(height:30),LayoutBuilder(builder:(c,x){final w=x.maxWidth<700?x.maxWidth:(x.maxWidth-20)/2;return Wrap(spacing:20,runSpacing:20,children:shown.map((p)=>SizedBox(width:w,child:_ProjectCard(p))).toList());})]);}}
class _Project{final String title,category,type,description;final List<String> tags;const _Project(this.title,this.category,this.type,this.description,this.tags);}
class _ProjectCard extends StatelessWidget{final _Project p;const _ProjectCard(this.p);@override Widget build(BuildContext c)=>Container(padding:const EdgeInsets.all(24),decoration:BoxDecoration(color:const Color(0xFFE9E1D6),border:Border.all(color:const Color(0xFFBDB4A8))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(p.category.toUpperCase(),style:const TextStyle(fontSize:11,fontWeight:FontWeight.w800,letterSpacing:1.5)),const SizedBox(height:18),Text(p.title,style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(p.type,style:const TextStyle(color:Color(0xFF6C655D),fontWeight:FontWeight.w600)),const SizedBox(height:18),Text(p.description,style:const TextStyle(fontSize:15,height:1.65,color:Color(0xFF4E4943))),const SizedBox(height:20),Wrap(spacing:7,runSpacing:7,children:p.tags.map((e)=>_Tag(e)).toList())]));}
class _Tag extends StatelessWidget{final String t;const _Tag(this.t);@override Widget build(BuildContext c)=>Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:6),decoration:BoxDecoration(border:Border.all(color:const Color(0xFF8E857A))),child:Text(t,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w600)));}

class _Skills extends StatelessWidget{const _Skills();@override Widget build(BuildContext c)=>const Wrap(spacing:45,runSpacing:35,children:[_Skill('Data Analytics',['Power BI','Tableau','Excel','Python','SQL','Data Cleaning','KPI Reporting']),_Skill('Development',['Flutter','Flutter Web','Dart','Firebase','Git','APIs']),_Skill('AI & Database',['Machine Learning','Deep Learning','Emotion Recognition','Database Design','Data Modeling'])]);}
class _Skill extends StatelessWidget{final String t;final List<String> x;const _Skill(this.t,this.x);@override Widget build(BuildContext c)=>SizedBox(width:300,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:12),Text(x.join('  •  '),style:const TextStyle(fontSize:15,height:1.8,color:Color(0xFF4E4943)))]));}

class _Contact extends StatelessWidget{const _Contact();@override Widget build(BuildContext c)=>const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Open to opportunities in data analytics, application development and practical technology projects.',style:TextStyle(fontSize:25,height:1.45,fontWeight:FontWeight.w800)),SizedBox(height:28),_ContactLine('Phone','0530460609'),_ContactLine('Email','fayalmtuairi@gmail.com'),_ContactLine('GitHub','github.com/FayAL-mtuairi'),_ContactLine('LinkedIn','linkedin.com/in/fay-al-mutairi-834a4a246')]);}
class _ContactLine extends StatelessWidget{final String a,b;const _ContactLine(this.a,this.b);@override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.symmetric(vertical:9),child:Wrap(spacing:18,children:[SizedBox(width:85,child:Text(a,style:const TextStyle(fontWeight:FontWeight.w800))),SelectableText(b)]));}
