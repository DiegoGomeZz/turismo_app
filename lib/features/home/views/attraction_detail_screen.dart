import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/features/home/providers/attraction_detail_provider.dart';
import 'package:turismo_app/features/home/views/widgets/create_event_button.dart';

class AttractionDetailScreen extends StatefulWidget {
  final AttractionModel attraction;

  const AttractionDetailScreen({super.key, required this.attraction});

  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> {
  late AttractionDetailProvider _controller;

  @override
  void initState() {
    super.initState();
    _controller = AttractionDetailProvider();
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
      body: AnimatedBuilder( //AnimatedBuilder escucha los cambios en el controlador y reconstruye la UI
        animation: _controller,
        builder: (context, child) {
          return CustomScrollView(
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

    final List<String> imagenesAMostrar = widget.attraction.todasLasImagenes;

    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      surfaceTintColor: Colors.transparent, 
      scrolledUnderElevation: 0,
      expandedHeight: 300.0,
      pinned: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        IconButton(icon: const Icon(Icons.share), onPressed: () {}),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.onImagePageChanged,
              itemCount: imagenesAMostrar.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: imagenesAMostrar[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            ),
            // Controles de imagen (Flechas y contador) solo si hay más de 1 imagen
            if (imagenesAMostrar.length > 1)
              Positioned(
                bottom: 16, left: 16, right: 16,
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
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        '${_controller.currentImageIndex + 1} / ${imagenesAMostrar.length}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: IconButton(
                        icon: const Icon(Icons.chevron_right, color: Colors.white),
                        onPressed: () => _controller.nextImage(imagenesAMostrar.length),
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
              '(${widget.attraction.cantidadVotos} reviews en nuestra App)',
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
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre este destino',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Ubicado en ${widget.attraction.direccion}, este es uno de los destinos más populares recomendados por nuestra comunidad.',
          style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
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