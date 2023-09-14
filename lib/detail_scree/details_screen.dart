

import 'package:bloc_pattern_challenge/model/user_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget{
  final UserModel userModel;

  const DetailScreen({super.key, required this.userModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1
    );
    _animationController.forward();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: AnimatedBuilder(
        animation: _animationController,

        builder: (context, child) => Padding(
          padding: EdgeInsets.only(
            top: 100- _animationController.value *100,
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: const DecorationImage(image: AssetImage('assets/images/background_2.jpg'), fit: BoxFit.cover)
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.userModel.avatar!,
                  child: CircleAvatar(maxRadius: 60,
                  backgroundImage: NetworkImage(widget.userModel.avatar!),
                  ),
                ),
                const SizedBox(height: 50),

                Text("${widget.userModel.firstName!} ${widget.userModel.lastName!}",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}