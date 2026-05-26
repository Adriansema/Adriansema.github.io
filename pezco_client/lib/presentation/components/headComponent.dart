import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';

class HeadComponent extends StatefulWidget {
  final String title;
  final bool? action;
  final IconData iconMain;
  final IconData? iconGo;
  final bool? inclinacion;
  final bool? claro;
  final double letra;

  const HeadComponent({
    super.key,
    required this.title,
    this.action,
    required this.iconMain,
    this.iconGo,
    this.inclinacion,
    this.claro,
    required this.letra,
  });

  @override
  State<HeadComponent> createState() => _HeadComponentState();
}

class _HeadComponentState extends State<HeadComponent> {
  bool _hoveredP = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxheight = constraints.maxHeight;
        return SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.inclinacion == true)
                if (widget.claro == true)
                  Container(
                    width: maxheight,
                    height: maxheight,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundElement,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(5.8),
                      child: Center(
                        child: Icon(
                          widget.iconMain,
                          color: Color(0xFF000000),
                          size: maxheight * 0.5,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: maxheight,
                    height: maxheight,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundComponent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(5.8),
                      child: Center(
                        child: Icon(
                          widget.iconMain,
                          color: Color(0xFF000000),
                          size: maxheight * 0.5,
                        ),
                      ),
                    ),
                  ),
              if (widget.inclinacion != true)
                if (widget.claro == true)
                  Container(
                    width: maxheight,
                    height: maxheight,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundElement,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Icon(
                        widget.iconMain,
                        color: Color(0xFF000000),
                        size: maxheight * 0.5,
                      ),
                    ),
                  )
                else if (widget.claro == false)
                  Container(
                    width: maxheight,
                    height: maxheight,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundComponent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Icon(
                        widget.iconMain,
                        color: Color(0xFF000000),
                        size: maxheight * 0.5,
                      ),
                    ),
                  )
                else
                  Container(
                    width: maxheight,
                    height: maxheight,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        right: BorderSide(color: Color(0xFF000000), width: 1),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        widget.iconMain,
                        color: Color(0xFF000000),
                        size: maxheight * 0.5,
                      ),
                    ),
                  ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: maxheight * widget.letra,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              if (widget.action != false)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: HoverRegion(
                    onEnter: () => setState(() => _hoveredP = true),
                    onExit: () => setState(() => _hoveredP = false),
                    child: Container(
                      width: maxheight,
                      height: maxheight,
                      decoration: BoxDecoration(
                        color: _hoveredP
                            ? AppColors.backgroundComponentNavigate
                            : Colors.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.iconGo,
                          color: _hoveredP
                              ? Color(0xFF000000)
                              : Color(0x80000000),
                          size: maxheight * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
