# Mythra — Uganda Myths for Children (Offline)

Mythra is a fully offline, kid-friendly Flutter app concept and scaffold for sharing Uganda's traditional stories, myths, heroes and creatures with children aged 7–14. This repository contains a minimal working scaffold that loads stories from a local JSON asset and displays them in a searchable list with basic tribe browsing and settings (theme + font-size).

## Features (implemented in this scaffold)

- Fully offline: stories and images are loaded from bundled assets.
- No login or internet required.
- Search stories by title, tribe or keywords (local search).
- Tribe browser (basic listing of tribes present in data).
- Story detail screen with image, tribe tag and full text.
- Settings with Light/Dark theme toggle and font-size options (persisted via SharedPreferences).

## Project structure (important files)

- `assets/stories/stories.json` — sample stories JSON (3 example stories).
- `assets/images/` — put your tribe images and thumbnails here. (Placeholders are used when an image is missing.)
- `lib/models/story.dart` — Story model.
- `lib/services/local_data_service.dart` — loads `stories.json` and provides search/tribe helpers.
- `lib/providers/theme_provider.dart` — theme and font-size persistence.
- `lib/screens/` — contains `stories_screen.dart`, `tribes_screen.dart`, `settings_screen.dart`, `story_detail_screen.dart`.
- `lib/app.dart` and `lib/main.dart` — app entry and theme wiring.

## How to run

1. Get dependencies:

```bash
flutter pub get
```

2. Run the app on an emulator or device:

```bash
flutter run
```

Or run on Linux desktop (if configured):

```bash
flutter run -d linux
```

If you see asset warnings about missing images, add image files to `assets/images/<tribe>/` (see `stories.json` for expected filenames) or place a placeholder image at `assets/images/common/placeholder_cover.png`.

## Adding stories & images

To add a story, edit `assets/stories/stories.json` and append a new object with the fields:

```json
{
	"id": "kintu-nambi",
	"title": "Kintu and Nambi",
	"tribe": "buganda",
	"tribeName": "Buganda",
	"shortDescription": "One-line description.",
	"fullText": "Full story text...",
	"image": "assets/images/buganda/kintu_nambi_cover.jpg",
	"thumbnail": "assets/images/buganda/kintu_nambi_thumb.jpg",
	"keywords": ["creation","sky"],
	"ageRange": "7-14",
	"readingTimeMins": 6,
	"order": 1
}
```

Add the referenced image files under `assets/images/<tribe>/` and make sure `pubspec.yaml` lists the `assets/images/` directory under `flutter.assets` (this scaffold already updates `pubspec.yaml`).

## Design notes & next steps

- The current UI is intentionally minimal to focus on offline data flow. You can extend the UI with nicer cards, illustrations, tribe intro pages, and random myth prompts.
- Consider adding more sample stories (15–30) and small PNG or WebP thumbnails for a friendly experience.
- Optional extra packages: `flutter_svg` for vector patterns, `cached_network_image` is not needed (offline), `riverpod` if you prefer a different state solution.

Tell me which option (A–E) you want next and I will implement it.

---

_(This README was generated and added to your project by an automated scaffold. Edit as needed.)_

