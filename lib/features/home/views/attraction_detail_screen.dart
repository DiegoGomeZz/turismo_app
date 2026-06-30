import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/features/home/controllers/attraction_detail_controller.dart';
import 'package:turismo_app/features/home/views/widgets/create_event_button.dart';

class AttractionDetailScreen extends StatefulWidget {
  final AttractionModel attraction;

  const AttractionDetailScreen({super.key, required this.attraction});

  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> {
  late AttractionDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AttractionDetailController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Usamos AnimatedBuilder para reconstruir solo cuando el controlador avise, 
      //el animated builder hace lo siguiente: se suscribe a los cambios del controlador 
      //y solo reconstruye la parte de la UI que depende de esos cambios, evitando reconstrucciones innecesarias de toda la pantalla.
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomScrollView( //CustomScrollView para tener un SliverAppBar con efecto de colapso y scroll suave
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderInfo(),
                      const SizedBox(height: 24),
                      _buildAboutSection(),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      _buildReviewsSection(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

    floatingActionButton: const CreateEventButton(),

    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      surfaceTintColor: Colors.transparent, 
      scrolledUnderElevation: 0,
      expandedHeight: 300.0,
      pinned: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () { /* Lógica de favoritos */ },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () { /* Lógica de compartir */ },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            //imágenes
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.onImagePageChanged,
              itemCount: widget.attraction.imageUrls.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.attraction.imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            ),
            // Sombreado superior para que se vean los iconos
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Controles de imagen (Flechas y contador)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: _controller.previousImage,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.image, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${_controller.currentImageIndex + 1} / ${widget.attraction.imageUrls.length}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () => _controller.nextImage(widget.attraction.imageUrls.length),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.attraction.titulo,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              widget.attraction.promedioEstrellas.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.star, color: Color.fromARGB(255, 255, 230, 0), size: 20),
            const SizedBox(width: 8),
            Text(
              '(${widget.attraction.cantidadVotos} reviews)',
              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.attraction.direccion,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
        if (widget.attraction.fechaEvento != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
              const SizedBox(width: 4),
              Text(
                '${widget.attraction.fechaEvento!.day}/${widget.attraction.fechaEvento!.month}/${widget.attraction.fechaEvento!.year}',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ]
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _controller.isDescriptionExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            widget.attraction.descripcion,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
          ),
          secondChild: Text(
            widget.attraction.descripcion,
            style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
          ),
        ),
        InkWell(
          onTap: _controller.toggleDescription,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
            child: Text(
              _controller.isDescriptionExpanded ? 'Leer menos' : '...Leer más',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    final stats = widget.attraction.estadisticasVotos;
    final total = widget.attraction.cantidadVotos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Sección de barras de puntuación
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  widget.attraction.promedioEstrellas.toString(),
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, height: 1.0),
                ),
                Row(
                  children: List.generate(widget.attraction.promedioEstrellas.toInt(), (index) => const Icon(Icons.star, color: Color.fromARGB(255, 255, 230, 0), size: 14)),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total opiniones',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                children: [
                  _buildRatingBar(5, stats.estrellas5, total),
                  _buildRatingBar(4, stats.estrellas4, total),
                  _buildRatingBar(3, stats.estrellas3, total),
                  _buildRatingBar(2, stats.estrellas2, total),
                  _buildRatingBar(1, stats.estrellas1, total),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Lista de Comentarios comprimida
        ...widget.attraction.comentarios.take(_controller.areReviewsExpanded ? widget.attraction.comentarios.length : 2).map((review) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(review.avatarUrl),
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(review.nombreUsuario, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text('${review.fecha.day}/${review.fecha.month}/${review.fecha.year}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(Icons.star, color: index < review.puntuacion ? Color.fromARGB(255, 255, 230, 0) : Colors.grey[300], size: 14),
                  ),
                ),
                const SizedBox(height: 8),
                Text(review.comentario, style: const TextStyle(fontSize: 14)),
              ],
            ),
          );
        }),
        if (widget.attraction.comentarios.length > 2)
          Center(
            child: OutlinedButton(
              onPressed: _controller.toggleReviews,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(_controller.areReviewsExpanded ? 'Ver menos' : 'Ver todos los comentarios'),
            ),
          ),
      ],
    );
  }

  Widget _buildRatingBar(int star, int count, int total) {
    final double percentage = total == 0 ? 0 : count / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text('$star', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 230, 0)),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}