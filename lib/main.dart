import 'package:flutter/material.dart';

void main()=>runApp(const FayPortfolio());

const _cream=Color(0xFFF6F1E8);
const _ink=Color(0xFF394236);
const _olive=Color(0xFF66735C);
const _line=Color(0xFFD1C8B9);
const _muted=Color(0xFF74766C);

class FayPortfolio extends StatelessWidget{
  const FayPortfolio({super.key});
  @override
  Widget build(BuildContext context)=>MaterialApp(
    debugShowCheckedModeBanner:false,
    title:'Fay Al-Mutairi | Portfolio',
    theme:ThemeData(
      useMaterial3:true,
      scaffoldBackgroundColor:_cream,
      colorScheme:ColorScheme.fromSeed(seedColor:_olive,surface:_cream),
      textTheme:Theme.of(context).textTheme.apply(bodyColor:_ink,displayColor:_ink),
    ),
    home:const PortfolioPage(),
  );
}

class PortfolioPage extends StatefulWidget{
  const PortfolioPage({super.key});
  @override State<PortfolioPage> createState()=>_PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>{
  final about=GlobalKey(),training=GlobalKey(),projects=GlobalKey(),skills=GlobalKey(),contact=GlobalKey();
  final ScrollController _scrollController=ScrollController();
  String active='About';

  @override
  void initState(){
    super.initState();
    _scrollController.addListener(_updateActiveSection);
  }

  void go(GlobalKey key){
    final sectionContext=key.currentContext;
    if(sectionContext!=null){
      Scrollable.ensureVisible(sectionContext,duration:const Duration(milliseconds:520),curve:Curves.easeOutCubic,alignment:.04);
    }
  }

  void _updateActiveSection(){
    final entries=<String,GlobalKey>{'About':about,'Training':training,'Projects':projects,'Skills':skills,'Contact':contact};
    String next=active;
    var best=double.infinity;
    for(final entry in entries.entries){
      final context=entry.value.currentContext;
      if(context==null)continue;
      final box=context.findRenderObject();
      if(box is! RenderBox||!box.attached)continue;
      final dy=box.localToGlobal(Offset.zero).dy.abs();
      if(dy<best){best=dy;next=entry.key;}
    }
    if(next!=active&&mounted)setState(()=>active=next);
  }

  @override
  void dispose(){
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final mobile=MediaQuery.sizeOf(context).width<760;
    return Scaffold(
      body:CustomScrollView(
        controller:_scrollController,
        slivers:[
          SliverAppBar(
            pinned:true,
            backgroundColor:_cream.withOpacity(.96),
            surfaceTintColor:Colors.transparent,
            elevation:0,
            title:const Row(children:[
              Text('FA',style:TextStyle(fontFamily:'serif',fontSize:28,fontWeight:FontWeight.w500,letterSpacing:-1,color:_ink)),
              SizedBox(width:14),
              SizedBox(height:22,child:VerticalDivider(width:1,thickness:1,color:_line)),
              SizedBox(width:14),
              Text('FAY AL-MUTAIRI',style:TextStyle(fontWeight:FontWeight.w600,fontSize:12,letterSpacing:3.0,color:_ink)),
            ]),
            actions:mobile
                ? [
                    PopupMenuButton<String>(
                      icon:const Icon(Icons.menu_rounded,color:_ink),
                      color:_cream,
                      onSelected:(value){
                        if(value=='About')go(about);
                        if(value=='Training')go(training);
                        if(value=='Projects')go(projects);
                        if(value=='Skills')go(skills);
                        if(value=='Contact')go(contact);
                      },
                      itemBuilder:(context)=>const [
                        PopupMenuItem(value:'About',child:Text('About')),
                        PopupMenuItem(value:'Training',child:Text('Training')),
                        PopupMenuItem(value:'Projects',child:Text('Projects')),
                        PopupMenuItem(value:'Skills',child:Text('Skills')),
                        PopupMenuItem(value:'Contact',child:Text('Contact')),
                      ],
                    ),
                    const SizedBox(width:8),
                  ]
                : [
                    _Nav('About',active=='About',()=>go(about)),
                    _Nav('Training',active=='Training',()=>go(training)),
                    _Nav('Projects',active=='Projects',()=>go(projects)),
                    _Nav('Skills',active=='Skills',()=>go(skills)),
                    _Nav('Contact',active=='Contact',()=>go(contact)),
                    const SizedBox(width:22),
                  ],
          ),
          SliverToBoxAdapter(
            child:Center(
              child:ConstrainedBox(
                constraints:const BoxConstraints(maxWidth:1220),
                child:Padding(
                  padding:EdgeInsets.symmetric(horizontal:mobile?20:28),
                  child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                    const SizedBox(height:42),
                    _Hero(controller:_scrollController,onWork:()=>go(projects)),
                    const SizedBox(height:105),
                    _Section(key:about,n:'01',title:'About',icon:Icons.person_outline,child:_About(scrollController:_scrollController)),
                    _Section(key:training,n:'02',title:'Training',icon:Icons.work_outline,child:_ScrollReveal(controller:_scrollController,animation:RevealAnimation.slideRight,child:const _Training())),
                    _Section(key:projects,n:'03',title:'Projects',icon:Icons.grid_view_rounded,child:_Projects(scrollController:_scrollController)),
                    _Section(key:skills,n:'04',title:'Skills',icon:Icons.auto_awesome_outlined,child:_ScrollReveal(controller:_scrollController,animation:RevealAnimation.scaleFade,child:const _Skills())),
                    _Section(key:contact,n:'05',title:'Contact',icon:Icons.mail_outline,child:_ScrollReveal(controller:_scrollController,animation:RevealAnimation.slideLeft,child:const _Contact())),
                    const Divider(color:_line),
                    const Padding(padding:EdgeInsets.symmetric(vertical:26),child:Text('Fay Al-Mutairi  •  Information Technology  •  Saudi Arabia',style:TextStyle(color:_muted))),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum RevealAnimation{fade,slideUp,slideLeft,slideRight,scaleFade}

class _ScrollReveal extends StatefulWidget{
  final Widget child;
  final ScrollController controller;
  final RevealAnimation animation;
  final Duration duration;
  final Duration delay;
  final double triggerFraction;
  final bool initiallyVisible;
  const _ScrollReveal({super.key,required this.child,required this.controller,this.animation=RevealAnimation.slideUp,this.duration=const Duration(milliseconds:520),this.delay=Duration.zero,this.triggerFraction=.9,this.initiallyVisible=false});
  @override State<_ScrollReveal> createState()=>_ScrollRevealState();
}

class _ScrollRevealState extends State<_ScrollReveal> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;
  late Animation<double> _curve;
  bool _revealed=false;
  bool _delayScheduled=false;
  @override void initState(){
    super.initState();
    _animationController=AnimationController(vsync:this,duration:widget.duration,value:widget.initiallyVisible?1:0);
    _curve=CurvedAnimation(parent:_animationController,curve:Curves.easeOutCubic);
    _revealed=widget.initiallyVisible;
    widget.controller.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_)=>_checkVisibility());
  }
  @override void didUpdateWidget(covariant _ScrollReveal oldWidget){
    super.didUpdateWidget(oldWidget);
    if(oldWidget.controller!=widget.controller){oldWidget.controller.removeListener(_handleScroll);widget.controller.addListener(_handleScroll);}
    if(oldWidget.duration!=widget.duration)_animationController.duration=widget.duration;
  }
  void _handleScroll()=>_checkVisibility();
  void _checkVisibility(){
    if(!mounted||_revealed)return;
    final renderObject=context.findRenderObject();
    if(renderObject is! RenderBox||!renderObject.attached||!renderObject.hasSize)return;
    final top=renderObject.localToGlobal(Offset.zero).dy;
    final bottom=top+renderObject.size.height;
    final viewportHeight=MediaQuery.sizeOf(context).height;
    final trigger=viewportHeight*widget.triggerFraction;
    if(bottom>0&&top<trigger){
      _revealed=true;
      if(widget.delay==Duration.zero){_animationController.forward();}
      else if(!_delayScheduled){_delayScheduled=true;Future.delayed(widget.delay,(){if(mounted)_animationController.forward();});}
    }
  }
  Offset _beginOffset(){
    switch(widget.animation){
      case RevealAnimation.slideLeft:return const Offset(-.07,0);
      case RevealAnimation.slideRight:return const Offset(.07,0);
      case RevealAnimation.slideUp:return const Offset(0,.07);
      case RevealAnimation.fade:
      case RevealAnimation.scaleFade:return Offset.zero;
    }
  }
  @override void dispose(){widget.controller.removeListener(_handleScroll);_animationController.dispose();super.dispose();}
  @override Widget build(BuildContext context){
    final beginOffset=_beginOffset();
    Widget animatedChild=widget.child;
    if(widget.animation==RevealAnimation.scaleFade){animatedChild=ScaleTransition(scale:Tween<double>(begin:.975,end:1).animate(_curve),child:animatedChild);}
    else if(beginOffset!=Offset.zero){animatedChild=SlideTransition(position:Tween<Offset>(begin:beginOffset,end:Offset.zero).animate(_curve),child:animatedChild);}
    return FadeTransition(opacity:_curve,child:animatedChild);
  }
}

class _Nav extends StatefulWidget{
  final String text;
  final bool active;
  final VoidCallback onPressed;
  const _Nav(this.text,this.active,this.onPressed);
  @override State<_Nav> createState()=>_NavState();
}
class _NavState extends State<_Nav>{
  bool hover=false;
  @override Widget build(BuildContext context)=>MouseRegion(
    onEnter:(_)=>setState(()=>hover=true),onExit:(_)=>setState(()=>hover=false),
    child:TextButton(
      onPressed:widget.onPressed,
      style:TextButton.styleFrom(foregroundColor:_ink,padding:const EdgeInsets.symmetric(horizontal:14,vertical:16)),
      child:Column(mainAxisSize:MainAxisSize.min,children:[
        AnimatedOpacity(duration:const Duration(milliseconds:180),opacity:hover||widget.active?1:.78,child:Text(widget.text,style:const TextStyle(fontSize:14,fontWeight:FontWeight.w500))),
        const SizedBox(height:5),
        AnimatedContainer(duration:const Duration(milliseconds:180),height:1.5,width:hover||widget.active?30:0,color:_olive),
      ]),
    ),
  );
}

class _Hero extends StatefulWidget{
  final VoidCallback onWork;
  final ScrollController controller;
  const _Hero({required this.onWork,required this.controller});
  @override State<_Hero> createState()=>_HeroState();
}

class _HeroState extends State<_Hero>{
  double scrollY=0;
  @override void initState(){super.initState();widget.controller.addListener(_onScroll);}
  @override void didUpdateWidget(covariant _Hero oldWidget){super.didUpdateWidget(oldWidget);if(oldWidget.controller!=widget.controller){oldWidget.controller.removeListener(_onScroll);widget.controller.addListener(_onScroll);}}
  void _onScroll(){
    if(!mounted)return;
    final double next=widget.controller.hasClients?widget.controller.offset.clamp(0.0,220.0).toDouble():0.0;
    if((next-scrollY).abs()>8)setState(()=>scrollY=next);
  }
  @override void dispose(){widget.controller.removeListener(_onScroll);super.dispose();}

  @override Widget build(BuildContext context)=>LayoutBuilder(builder:(context,constraints){
    final mobile=constraints.maxWidth<780;
    final copy=_HeroCopy(onWork:widget.onWork,mobile:mobile);
    final visual=Transform.translate(offset:Offset(0,-scrollY*.045),child:_HeroVisual(mobile:mobile));
    final core=mobile
        ? Column(crossAxisAlignment:CrossAxisAlignment.start,children:[copy,const SizedBox(height:34),visual,const SizedBox(height:18),const Align(alignment:Alignment.center,child:_ScrollHint(compact:true))])
        : Row(crossAxisAlignment:CrossAxisAlignment.center,children:[
            Expanded(flex:6,child:copy),
            const SizedBox(width:34),
            Expanded(flex:5,child:visual),
          ]);
    return SizedBox(
      width:double.infinity,
      child:Stack(
        clipBehavior:Clip.none,
        children:[
          if(!mobile)...[
            const Positioned(left:0,top:36,bottom:42,child:_HeroRail()),
            Positioned(right:0,bottom:4,child:Transform.translate(offset:Offset(0,-scrollY*.025),child:const _ScrollHint())),
          ],
          Padding(
            padding:EdgeInsets.only(left:mobile?0:58,right:mobile?0:54),
            child:core,
          ),
        ],
      ),
    );
  });
}

class _HeroRail extends StatelessWidget{
  const _HeroRail();
  @override
  Widget build(BuildContext context)=>SizedBox(
    width:44,
    child:Column(
      children:[
        Expanded(
          child:Stack(
            alignment:Alignment.bottomCenter,
            children:[
              const Positioned.fill(left:21,right:21,child:ColoredBox(color:_line)),
              Positioned(
                bottom:22,
                left:-24,
                child:Opacity(
                  opacity:.12,
                  child:Transform.rotate(angle:-.16,child:const Icon(Icons.local_florist_outlined,size:124,color:_olive)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height:16),
        const Text('01',style:TextStyle(fontSize:11,color:_olive,fontWeight:FontWeight.w600)),
        const SizedBox(height:7),
        Container(width:16,height:1,color:_line),
        const SizedBox(height:7),
        const Text('04',style:TextStyle(fontSize:11,color:_muted,fontWeight:FontWeight.w600)),
      ],
    ),
  );
}

class _ScrollHint extends StatelessWidget{
  final bool compact;
  const _ScrollHint({this.compact=false});
  @override
  Widget build(BuildContext context)=>Column(
    mainAxisSize:MainAxisSize.min,
    children:[
      Container(
        width:compact?19:22,
        height:compact?34:40,
        decoration:BoxDecoration(border:Border.all(color:_olive,width:1.2),borderRadius:BorderRadius.circular(13)),
        child:Align(
          alignment:const Alignment(0,-.52),
          child:Container(width:2,height:7,decoration:BoxDecoration(color:_olive,borderRadius:BorderRadius.circular(2))),
        ),
      ),
      const SizedBox(height:8),
      Text('Scroll\ndown',textAlign:TextAlign.center,style:TextStyle(fontSize:compact?9.5:10.5,height:1.05,color:_muted,fontWeight:FontWeight.w500)),
      const SizedBox(height:8),
      Icon(Icons.arrow_downward_rounded,size:compact?18:20,color:_olive),
    ],
  );
}

class _HeroCopy extends StatelessWidget{
  final VoidCallback onWork;
  final bool mobile;
  const _HeroCopy({required this.onWork,required this.mobile});
  @override Widget build(BuildContext context)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    const Row(children:[Icon(Icons.code_rounded,size:15,color:_olive),SizedBox(width:9),Text('INFORMATION TECHNOLOGY',style:TextStyle(fontSize:11.5,fontWeight:FontWeight.w700,letterSpacing:2.8,color:_olive))]),
    const SizedBox(height:26),
    Text('Fay Al-Mutairi',maxLines:2,style:TextStyle(fontFamily:'serif',fontSize:mobile?58:82,height:.95,fontWeight:FontWeight.w500,letterSpacing:-2.5,color:_ink)),
    const SizedBox(height:28),
    ConstrainedBox(constraints:const BoxConstraints(maxWidth:590),child:const Text('IT graduate focused on data analytics, Flutter development and practical AI. My work combines hands-on training with projects built around real interfaces, datasets, APIs and software solutions.',style:TextStyle(fontSize:18,height:1.7,color:_muted))),
    const SizedBox(height:30),
    _HeroButton(onPressed:onWork),
  ]);
}

class _HeroButton extends StatefulWidget{final VoidCallback onPressed;const _HeroButton({required this.onPressed});@override State<_HeroButton> createState()=>_HeroButtonState();}
class _HeroButtonState extends State<_HeroButton>{bool hover=false;@override Widget build(BuildContext context)=>MouseRegion(onEnter:(_)=>setState(()=>hover=true),onExit:(_)=>setState(()=>hover=false),child:FilledButton(onPressed:widget.onPressed,style:FilledButton.styleFrom(backgroundColor:_olive,foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(horizontal:28,vertical:18),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30))),child:Row(mainAxisSize:MainAxisSize.min,children:[const Text('View my work',style:TextStyle(fontWeight:FontWeight.w600)),const SizedBox(width:12),AnimatedSlide(duration:const Duration(milliseconds:180),offset:hover?const Offset(.16,0):Offset.zero,child:const Icon(Icons.arrow_forward_rounded,size:18))])));}

class _HeroVisual extends StatelessWidget{
  final bool mobile;
  const _HeroVisual({required this.mobile});
  @override Widget build(BuildContext context){
    final h=mobile?500.0:570.0;
    return SizedBox(
      height:h,
      child:Stack(
        clipBehavior:Clip.none,
        children:[
          Positioned(
            left:mobile?34:52,
            top:mobile?34:28,
            right:mobile?28:28,
            bottom:mobile?24:18,
            child:Container(
              decoration:BoxDecoration(
                color:const Color(0xFFE4E5D8),
                borderRadius:BorderRadius.only(
                  topLeft:Radius.circular(mobile?145:205),
                  topRight:Radius.circular(mobile?145:205),
                ),
              ),
            ),
          ),
          Positioned(
            left:mobile?20:28,
            top:mobile?54:44,
            right:mobile?42:48,
            bottom:mobile?30:24,
            child:Container(
              decoration:BoxDecoration(
                border:Border.all(color:_line),
                borderRadius:BorderRadius.only(
                  topLeft:Radius.circular(mobile?132:190),
                  topRight:Radius.circular(mobile?132:190),
                ),
              ),
              padding:const EdgeInsets.all(12),
              child:ClipRRect(
                borderRadius:BorderRadius.only(
                  topLeft:Radius.circular(mobile?120:178),
                  topRight:Radius.circular(mobile?120:178),
                ),
                child:ColoredBox(
                  color:const Color(0xFFE9E6DC),
                  child:ColorFiltered(
                    colorFilter:const ColorFilter.mode(Color(0x159A9A83),BlendMode.multiply),
                    child:Image.asset(
                      'assets/IMG_6645.PNG',
                      fit:BoxFit.contain,
                      alignment:Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(left:mobile?2:0,top:mobile?128:126,child:const _TechFloat(label:'Power BI',icon:Icons.bar_chart_rounded)),
          Positioned(right:mobile?4:0,top:mobile?56:58,child:const _TechFloat(label:'Python',icon:Icons.code_rounded)),
          Positioned(left:mobile?12:12,bottom:mobile?104:110,child:const _TechFloat(label:'SQL',icon:Icons.storage_rounded)),
          Positioned(right:mobile?2:0,top:mobile?210:214,child:const _TechFloat(label:'Flutter',icon:Icons.phone_iphone_rounded)),
          Positioned(right:mobile?6:10,bottom:mobile?62:70,child:const _TechFloat(label:'Excel',icon:Icons.table_chart_outlined)),
          Positioned(left:mobile?54:54,bottom:mobile?0:0,child:const _InsightCard()),
        ],
      ),
    );
  }
}

class _TechFloat extends StatefulWidget{final String label;final IconData icon;const _TechFloat({required this.label,required this.icon});@override State<_TechFloat> createState()=>_TechFloatState();}
class _TechFloatState extends State<_TechFloat>{bool hover=false;@override Widget build(BuildContext context)=>MouseRegion(onEnter:(_)=>setState(()=>hover=true),onExit:(_)=>setState(()=>hover=false),child:AnimatedContainer(duration:const Duration(milliseconds:180),transform:Matrix4.translationValues(0,hover?-4:0,0),padding:const EdgeInsets.symmetric(horizontal:16,vertical:13),decoration:BoxDecoration(color:_cream,border:Border.all(color:_line),borderRadius:BorderRadius.circular(14),boxShadow:const [BoxShadow(color:Color(0x10000000),blurRadius:16,offset:Offset(0,7))]),child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(widget.icon,size:20,color:_olive),const SizedBox(width:9),Text(widget.label,style:const TextStyle(fontSize:13.5,fontWeight:FontWeight.w600,color:_ink))])));}
class _InsightCard extends StatelessWidget{const _InsightCard();@override Widget build(BuildContext context)=>Container(width:190,padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:_cream,border:Border.all(color:_line),borderRadius:BorderRadius.circular(12)),child:const Row(children:[Icon(Icons.show_chart_rounded,color:_olive),SizedBox(width:12),Expanded(child:Text('Turn data into insights',style:TextStyle(fontSize:12.5,height:1.3,fontWeight:FontWeight.w600,color:_ink))),Icon(Icons.arrow_forward_rounded,size:16,color:_olive)]));}

class _Section extends StatelessWidget{final String n,title;final IconData icon;final Widget child;const _Section({super.key,required this.n,required this.title,required this.icon,required this.child});@override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.only(bottom:95),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Divider(color:_line),const SizedBox(height:16),Row(children:[Container(width:42,height:42,decoration:BoxDecoration(color:_olive,borderRadius:BorderRadius.circular(12)),child:Icon(icon,color:Colors.white,size:21)),const SizedBox(width:14),Text('$n   $title',style:const TextStyle(fontSize:34,fontWeight:FontWeight.w900,letterSpacing:-1,color:_ink))]),const SizedBox(height:38),child]));}

class _About extends StatelessWidget{final ScrollController scrollController;const _About({required this.scrollController});@override Widget build(BuildContext context)=>LayoutBuilder(builder:(context,constraints){final mobile=constraints.maxWidth<760;final story=Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('I like turning ideas into clear, useful digital experiences.',style:TextStyle(fontSize:mobile?32:46,height:1.08,fontWeight:FontWeight.w900,letterSpacing:-1.2,color:_ink)),const SizedBox(height:22),const Text('I am an Information Technology graduate from Qassim University. My work sits between data, product thinking and development — from dashboards and data cleaning to Flutter applications, APIs, Firebase and practical AI.',style:TextStyle(fontSize:18,height:1.7,color:_muted)),const SizedBox(height:18),const Text('What matters to me is not just making something work, but making it understandable, organized and pleasant to use.',style:TextStyle(fontSize:18,height:1.7,color:_muted)),const SizedBox(height:28),_ScrollReveal(controller:scrollController,animation:RevealAnimation.slideUp,duration:const Duration(milliseconds:420),child:const Wrap(spacing:10,runSpacing:10,children:[_AboutPill(Icons.insights_outlined,'Data Analytics'),_AboutPill(Icons.phone_iphone_rounded,'Flutter'),_AboutPill(Icons.memory_outlined,'Practical AI'),_AboutPill(Icons.design_services_outlined,'UI thinking')]))]);final visual=_ScrollReveal(controller:scrollController,animation:RevealAnimation.scaleFade,duration:const Duration(milliseconds:500),child:Container(height:mobile?330:430,decoration:BoxDecoration(color:_ink,borderRadius:BorderRadius.circular(26)),child:Stack(children:[Positioned.fill(child:CustomPaint(painter:_OrbitPainter())),const Align(alignment:Alignment.center,child:_CoreNode()),const Positioned(top:52,left:48,child:_SkillNode(label:'DATA',icon:Icons.bar_chart_rounded)),const Positioned(top:72,right:42,child:_SkillNode(label:'FLUTTER',icon:Icons.phone_android_rounded)),const Positioned(bottom:62,left:58,child:_SkillNode(label:'AI',icon:Icons.auto_awesome_rounded)),const Positioned(bottom:48,right:52,child:_SkillNode(label:'UX',icon:Icons.draw_outlined))])));return mobile?Column(crossAxisAlignment:CrossAxisAlignment.start,children:[story,const SizedBox(height:30),visual]):Row(crossAxisAlignment:CrossAxisAlignment.center,children:[Expanded(flex:6,child:story),const SizedBox(width:52),Expanded(flex:5,child:visual)]);});}
class _AboutPill extends StatelessWidget{final IconData icon;final String text;const _AboutPill(this.icon,this.text);@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:14,vertical:10),decoration:BoxDecoration(border:Border.all(color:_line),borderRadius:BorderRadius.circular(22)),child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(icon,size:17,color:_olive),const SizedBox(width:8),Text(text,style:const TextStyle(fontWeight:FontWeight.w700,color:_ink))]));}
class _CoreNode extends StatelessWidget{const _CoreNode();@override Widget build(BuildContext context)=>Container(width:112,height:112,decoration:const BoxDecoration(shape:BoxShape.circle,color:_cream,boxShadow:[BoxShadow(color:Color(0x335B674F),blurRadius:34,spreadRadius:2)]),child:const Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.hub_outlined,size:28,color:_olive),SizedBox(height:6),Text('FAY',style:TextStyle(fontWeight:FontWeight.w900,letterSpacing:1.4,color:_ink))]));}
class _SkillNode extends StatelessWidget{final String label;final IconData icon;const _SkillNode({required this.label,required this.icon});@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:13,vertical:10),decoration:BoxDecoration(color:const Color(0xFF2A2F28),borderRadius:BorderRadius.circular(20),border:Border.all(color:const Color(0xFF4B5545))),child:Row(mainAxisSize:MainAxisSize.min,children:[Icon(icon,size:16,color:_cream),const SizedBox(width:7),Text(label,style:const TextStyle(color:_cream,fontSize:11,fontWeight:FontWeight.w800,letterSpacing:1.1))]));}
class _OrbitPainter extends CustomPainter{@override void paint(Canvas canvas,Size size){final primary=Paint()..color=const Color(0xFF69715F)..strokeWidth=1.2..style=PaintingStyle.stroke;final center=Offset(size.width/2,size.height/2);canvas.drawCircle(center,size.shortestSide*.28,primary);final secondary=Paint()..color=const Color(0xFF343930)..strokeWidth=1.2..style=PaintingStyle.stroke;canvas.drawCircle(center,size.shortestSide*.39,secondary);final line=Paint()..color=const Color(0xFF4A5245)..strokeWidth=1;canvas.drawLine(center,Offset(size.width*.18,size.height*.18),line);canvas.drawLine(center,Offset(size.width*.82,size.height*.22),line);canvas.drawLine(center,Offset(size.width*.2,size.height*.78),line);canvas.drawLine(center,Offset(size.width*.82,size.height*.8),line);}@override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}

class _Training extends StatelessWidget{const _Training();@override Widget build(BuildContext context)=>const Column(children:[_TrainingCard(title:'Data Analysis Intern',place:'Al Qassim Municipality • Data Management & Statistics Office',period:'June – August 2025',body:'Completed an 8-week cooperative training program in a government data environment. Worked on cleaning and validating 750+ municipal records, reviewing data quality and inconsistencies, and supporting KPI reporting. Built analytical dashboards with Power BI and Excel for quarterly comparisons and clearer decision-support reporting. Internal datasets and work samples are not displayed because the training was completed within a government entity.',tags:['Power BI','Excel','Data Cleaning','Data Validation','KPI Reporting','Data Visualization'],image:'assets/projects/training.png'),_TrainingCard(title:'Application Development Intern',place:'Kharja • Startup',period:'February – May 2024',body:'Worked in application development using Flutter and Dart, with Firebase for authentication, database and backend-connected services. The training strengthened my understanding of UI/UX implementation, mobile application structure, software-development workflow and turning interface concepts into functional application screens.',tags:['Flutter','Dart','Firebase','UI/UX','Mobile Development','Git'])]);}
class _TrainingCard extends StatelessWidget{final String title,place,period,body;final List<String> tags;final String? image;const _TrainingCard({required this.title,required this.place,required this.period,required this.body,required this.tags,this.image});@override Widget build(BuildContext context)=>Container(width:double.infinity,padding:const EdgeInsets.symmetric(vertical:30),decoration:const BoxDecoration(border:Border(bottom:BorderSide(color:_line))),child:LayoutBuilder(builder:(context,constraints){final compact=constraints.maxWidth<760;final text=Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w800,color:_ink)),const SizedBox(height:6),Text(place,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w700,color:_ink)),Text(period,style:const TextStyle(color:_muted)),const SizedBox(height:16),Text(body,style:const TextStyle(fontSize:16,height:1.65,color:_muted)),const SizedBox(height:16),Wrap(spacing:8,runSpacing:8,children:tags.map((e)=>_Tag(e)).toList())]);if(image==null)return text;final certificate=Container(height:compact?170:190,width:double.infinity,padding:const EdgeInsets.all(10),color:Colors.white,child:Image.asset(image!,fit:BoxFit.contain));return compact?Column(crossAxisAlignment:CrossAxisAlignment.start,children:[text,const SizedBox(height:20),certificate]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:7,child:text),const SizedBox(width:28),Expanded(flex:3,child:certificate)]);}));}

class _Projects extends StatefulWidget{final ScrollController scrollController;const _Projects({required this.scrollController});@override State<_Projects> createState()=>_ProjectsState();}
class _ProjectsState extends State<_Projects>{String filter='All';static const items=[_Project('Anees','AI','Graduation Project','A wellbeing application and AI-focused graduation project designed around emotion understanding and supportive user experiences. The interfaces include mood check-ins, habit tracking, breathing exercises, community support, and interaction through voice or camera. The AI work explored multimodal emotion recognition using audio, facial and video inputs and datasets including RAVDESS and MELD.',['AI','Deep Learning','Flutter','Emotion Recognition'],['assets/projects/anees-1.png','assets/projects/anees-2.png','assets/projects/anees-3.png','assets/projects/anees-4.png','assets/projects/anees-5.png']),_Project('Weather Dashboard','Data Analytics','API • Dashboard','A weather dashboard connected to an API and refreshed periodically. It presents current conditions, multi-day forecasts, humidity, wind speed, visibility, pressure, UV index, precipitation, sunrise/sunset and air-quality indicators in one visual view.',['API','Dashboard','Data Visualization'],['assets/projects/weather.jpg']),_Project('Sales Dashboard','Data Analytics','Business Analytics','A clean sales dashboard created to demonstrate analysis and visualization skills through KPIs, sales and revenue comparisons, customers, product performance, trends and weekly category views.',['Power BI','KPIs','Sales Analytics'],['assets/projects/sales.jpg']),_Project('COVID-19 Dashboard','Data Analytics','Tableau • Large Dataset','Built from a large COVID-19 dataset in Tableau to explore deaths by continent, population infection percentages, country comparisons, geographic distribution and overall cases and deaths.',['Tableau','Large Dataset','Analytics'],['assets/projects/covid.png']),_Project('Real Estate App','Flutter & Mobile','Flutter','A simple real-estate mobile application with property browsing, search and filters. Users can browse houses, villas and apartments and narrow listings through a straightforward mobile interface.',['Flutter','Mobile','Filters'],['assets/projects/realestate-1.png','assets/projects/realestate-2.png']),_Project('Graduation Projects Platform','Flutter & Mobile','Flutter Web','A Flutter Web platform created as a dedicated space for students to showcase graduation projects. Students submit their projects through a structured form, making project sharing and discovery more organized.',['Flutter Web','Forms','UI/UX'],['assets/projects/gradplatform.png']),_Project('Kharja','Flutter & Mobile','Mobile Application','A mobile application project developed around planning outings and nearby activities. The interface includes creating a new outing, adding a cover image, title and description, and selecting categories such as sports, food, music, gaming, arts and culture.',['Flutter','Mobile Development','UI/UX'],['assets/projects/kharja-1.png','assets/projects/kharja-2.png']),_Project('Library Database Schema','Web & Database','Database Design','A database-design project for a university library system focused on entities, relationships and organized information structure.',['Database Design','SQL','Data Modeling'],[])];@override Widget build(BuildContext context){const filters=['All','Data Analytics','Flutter & Mobile','AI','Web & Database'];final shown=filter=='All'?items:items.where((e)=>e.category==filter).toList();return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Browse by area. Open a project to see the full description, skills and images.',style:TextStyle(fontSize:16,height:1.6,color:_muted)),const SizedBox(height:18),Wrap(spacing:9,runSpacing:9,children:filters.map((e)=>ChoiceChip(label:Text(e),selected:filter==e,onSelected:(_)=>setState(()=>filter=e),selectedColor:_olive,labelStyle:TextStyle(color:filter==e?Colors.white:_ink),backgroundColor:_cream,side:const BorderSide(color:_line))).toList()),const SizedBox(height:30),LayoutBuilder(builder:(context,constraints){final width=constraints.maxWidth<700?constraints.maxWidth:(constraints.maxWidth-20)/2;return Wrap(spacing:20,runSpacing:20,children:shown.asMap().entries.map((entry){final delay=Duration(milliseconds:(entry.key%4)*70);return SizedBox(width:width,child:_ScrollReveal(key:ValueKey('${filter}_${entry.value.title}'),controller:widget.scrollController,animation:RevealAnimation.slideUp,duration:const Duration(milliseconds:460),delay:delay,triggerFraction:.92,child:_ProjectCard(entry.value)));}).toList());})]);}}
class _Project{final String title,category,type,description;final List<String> tags,images;const _Project(this.title,this.category,this.type,this.description,this.tags,this.images);}
class _ProjectCard extends StatefulWidget{final _Project project;const _ProjectCard(this.project);@override State<_ProjectCard> createState()=>_ProjectCardState();}
class _ProjectCardState extends State<_ProjectCard>{
  bool hovered=false;
  @override
  Widget build(BuildContext context){
    final project=widget.project;
    final cover=project.images.isNotEmpty?project.images.first:null;
    return MouseRegion(
      onEnter:(_)=>setState(()=>hovered=true),
      onExit:(_)=>setState(()=>hovered=false),
      child:AnimatedContainer(
        duration:const Duration(milliseconds:180),
        curve:Curves.easeOut,
        transform:Matrix4.translationValues(0,hovered?-5:0,0),
        decoration:BoxDecoration(
          boxShadow:hovered?const [BoxShadow(color:Color(0x15000000),blurRadius:22,offset:Offset(0,12))]:const [],
        ),
        child:Material(
          color:_cream,
          child:InkWell(
            onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>_ProjectDetails(project))),
            child:Container(
              decoration:BoxDecoration(border:Border.all(color:hovered?_olive:_line)),
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  if(cover!=null)
                    ClipRect(
                      child:AnimatedScale(
                        scale:hovered?1.025:1,
                        duration:const Duration(milliseconds:220),
                        curve:Curves.easeOut,
                        child:Container(
                          height:210,
                          width:double.infinity,
                          color:const Color(0xFFFBF8F2),
                          padding:const EdgeInsets.all(16),
                          child:Image.asset(cover,fit:BoxFit.contain),
                        ),
                      ),
                    ),
                  Padding(
                    padding:const EdgeInsets.all(22),
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:[
                        Text(project.category.toUpperCase(),style:const TextStyle(fontSize:11,fontWeight:FontWeight.w800,letterSpacing:1.5,color:_olive)),
                        const SizedBox(height:12),
                        Text(project.title,style:const TextStyle(fontSize:26,fontWeight:FontWeight.w800,color:_ink)),
                        const SizedBox(height:7),
                        Text(project.type,style:const TextStyle(color:_muted,fontWeight:FontWeight.w600)),
                        const SizedBox(height:14),
                        Text(project.description,maxLines:3,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:14.5,height:1.55,color:_muted)),
                        const SizedBox(height:16),
                        Wrap(spacing:7,runSpacing:7,children:project.tags.take(3).map((e)=>_Tag(e)).toList()),
                        const SizedBox(height:18),
                        Row(children:[
                          const Text('View project',style:TextStyle(fontWeight:FontWeight.w700,color:_ink)),
                          const SizedBox(width:7),
                          AnimatedSlide(duration:const Duration(milliseconds:180),offset:hovered?const Offset(.18,0):Offset.zero,child:const Icon(Icons.arrow_forward_rounded,size:17,color:_olive)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectDetails extends StatefulWidget{final _Project project;const _ProjectDetails(this.project);@override State<_ProjectDetails> createState()=>_ProjectDetailsState();}
class _ProjectDetailsState extends State<_ProjectDetails>{late final PageController pageController;int current=0;@override void initState(){super.initState();pageController=PageController(viewportFraction:.7);}@override void dispose(){pageController.dispose();super.dispose();}@override Widget build(BuildContext context){final project=widget.project;final phone=project.images.length>1&&(project.title=='Anees'||project.title=='Real Estate App'||project.title=='Kharja');return Scaffold(backgroundColor:_cream,appBar:AppBar(backgroundColor:_cream,surfaceTintColor:Colors.transparent,title:Text(project.title,style:const TextStyle(fontWeight:FontWeight.w800,color:_ink))),body:SingleChildScrollView(child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1040),child:Padding(padding:const EdgeInsets.fromLTRB(24,36,24,70),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(project.category.toUpperCase(),style:const TextStyle(fontSize:12,fontWeight:FontWeight.w800,letterSpacing:1.8,color:_olive)),const SizedBox(height:12),Text(project.title,style:const TextStyle(fontSize:48,height:1,fontWeight:FontWeight.w900,letterSpacing:-1.5,color:_ink)),const SizedBox(height:10),Text(project.type,style:const TextStyle(fontSize:17,color:_muted,fontWeight:FontWeight.w700)),const SizedBox(height:28),Text(project.description,style:const TextStyle(fontSize:18,height:1.75,color:_muted)),const SizedBox(height:24),Wrap(spacing:8,runSpacing:8,children:project.tags.map((e)=>_Tag(e)).toList()),if(project.images.isNotEmpty)...[const SizedBox(height:42),const Divider(color:_line),const SizedBox(height:22),const Text('Project Gallery',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900,color:_ink)),const SizedBox(height:18),phone?_PhoneCarousel(images:project.images,controller:pageController,current:current,onChanged:(index)=>setState(()=>current=index)):_DetailsGallery(project.images)]]))))));}}
class _PhoneCarousel extends StatelessWidget{final List<String> images;final PageController controller;final int current;final ValueChanged<int> onChanged;const _PhoneCarousel({required this.images,required this.controller,required this.current,required this.onChanged});@override Widget build(BuildContext context)=>Column(children:[SizedBox(height:520,child:PageView.builder(controller:controller,itemCount:images.length,onPageChanged:onChanged,physics:const BouncingScrollPhysics(),itemBuilder:(context,index){final active=index==current;return AnimatedScale(scale:active?1:.88,duration:const Duration(milliseconds:260),curve:Curves.easeOut,child:AnimatedOpacity(opacity:active?1:.55,duration:const Duration(milliseconds:260),child:Center(child:_PhoneFrame(image:images[index]))));})),const SizedBox(height:14),Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(images.length,(index){final active=index==current;return AnimatedContainer(duration:const Duration(milliseconds:220),margin:const EdgeInsets.symmetric(horizontal:4),width:active?24:7,height:7,decoration:BoxDecoration(color:active?_ink:_line,borderRadius:BorderRadius.circular(20)));}))]);}
class _PhoneFrame extends StatelessWidget{final String image;const _PhoneFrame({required this.image});@override Widget build(BuildContext context)=>Container(width:245,height:500,padding:const EdgeInsets.all(9),decoration:BoxDecoration(color:_ink,borderRadius:BorderRadius.circular(34),boxShadow:const [BoxShadow(blurRadius:22,offset:Offset(0,12),color:Color(0x22000000))]),child:Stack(children:[ClipRRect(borderRadius:BorderRadius.circular(26),child:Container(color:Colors.white,width:double.infinity,height:double.infinity,child:Image.asset(image,fit:BoxFit.contain))),Align(alignment:Alignment.topCenter,child:Container(width:78,height:18,margin:const EdgeInsets.only(top:7),decoration:BoxDecoration(color:_ink,borderRadius:BorderRadius.circular(14))))]));}
class _DetailsGallery extends StatelessWidget{final List<String> images;const _DetailsGallery(this.images);@override Widget build(BuildContext context)=>LayoutBuilder(builder:(context,constraints){if(images.length==1)return Center(child:ConstrainedBox(constraints:const BoxConstraints(maxHeight:520,maxWidth:900),child:Container(width:double.infinity,padding:const EdgeInsets.all(16),color:Colors.white,child:Image.asset(images.first,fit:BoxFit.contain))));final mobile=constraints.maxWidth<700;final width=mobile?constraints.maxWidth:(constraints.maxWidth-16)/2;return Wrap(spacing:16,runSpacing:16,children:images.map((image)=>Container(width:width,height:300,padding:const EdgeInsets.all(14),color:Colors.white,child:Image.asset(image,fit:BoxFit.contain))).toList());});}
class _Tag extends StatelessWidget{final String text;const _Tag(this.text);@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:6),decoration:BoxDecoration(border:Border.all(color:_line),borderRadius:BorderRadius.circular(18)),child:Text(text,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w600,color:_ink)));}
class _Skills extends StatelessWidget{const _Skills();@override Widget build(BuildContext context)=>const Wrap(spacing:45,runSpacing:35,children:[_Skill('Data Analytics',['Power BI','Tableau','Excel','Python','SQL','Data Cleaning','KPI Reporting'],Icons.insights_outlined),_Skill('Development',['Flutter','Flutter Web','Dart','Firebase','Git','APIs'],Icons.devices_outlined),_Skill('AI & Database',['Machine Learning','Deep Learning','Emotion Recognition','Database Design','Data Modeling'],Icons.memory_outlined)]);}
class _Skill extends StatelessWidget{final String title;final List<String> items;final IconData icon;const _Skill(this.title,this.items,this.icon);@override Widget build(BuildContext context)=>SizedBox(width:300,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:40,height:40,decoration:BoxDecoration(border:Border.all(color:_olive),borderRadius:BorderRadius.circular(10)),child:Icon(icon,size:20,color:_olive)),const SizedBox(height:14),Text(title,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800,color:_ink)),const SizedBox(height:12),Text(items.join('  •  '),style:const TextStyle(fontSize:15,height:1.8,color:_muted))]));}
class _Contact extends StatelessWidget{const _Contact();@override Widget build(BuildContext context)=>const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Open to opportunities in data analytics, application development and practical technology projects.',style:TextStyle(fontSize:25,height:1.45,fontWeight:FontWeight.w800,color:_ink)),SizedBox(height:28),_ContactLine(Icons.phone_outlined,'Phone','0530460609'),_ContactLine(Icons.mail_outline,'Email','fayalmtuairi@gmail.com'),_ContactLine(Icons.code_outlined,'GitHub','github.com/FayAL-mtuairi'),_ContactLine(Icons.link_outlined,'LinkedIn','linkedin.com/in/fay-al-mutairi-834a4a246')]);}
class _ContactLine extends StatelessWidget{final IconData icon;final String label,value;const _ContactLine(this.icon,this.label,this.value);@override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:9),child:Wrap(crossAxisAlignment:WrapCrossAlignment.center,spacing:12,children:[Icon(icon,size:18,color:_olive),SizedBox(width:85,child:Text(label,style:const TextStyle(fontWeight:FontWeight.w800,color:_ink))),SelectableText(value,style:const TextStyle(color:_muted))]));}
