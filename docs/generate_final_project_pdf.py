"""Generate the Flutter course final-project PDF for students."""

from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_JUSTIFY, TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import (
    CondPageBreak,
    KeepTogether,
    ListFlowable,
    ListItem,
    PageBreak,
    Paragraph,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
)

NAVY = colors.HexColor("#1B2430")
ORANGE = colors.HexColor("#E85D04")
TEAL = colors.HexColor("#0F766E")
CREAM = colors.HexColor("#FFF7ED")
SOFT = colors.HexColor("#F4F6F8")
LINE = colors.HexColor("#D6DEE6")
MUTED = colors.HexColor("#5B6775")
WHITE = colors.white
GREEN = colors.HexColor("#166534")
AMBER = colors.HexColor("#92400E")
RED = colors.HexColor("#9F1239")

OUT = Path(__file__).with_name("Flutter_Final_Project_Food_Delivery.pdf")


def styles():
    base = getSampleStyleSheet()
    s = {
        "cover_kicker": ParagraphStyle(
            "cover_kicker",
            parent=base["Normal"],
            fontName="Helvetica-Bold",
            fontSize=11,
            textColor=ORANGE,
            letterSpacing=1.2,
            alignment=TA_CENTER,
            spaceAfter=10,
        ),
        "cover_title": ParagraphStyle(
            "cover_title",
            parent=base["Title"],
            fontName="Helvetica-Bold",
            fontSize=28,
            leading=34,
            textColor=NAVY,
            alignment=TA_CENTER,
            spaceAfter=10,
        ),
        "cover_sub": ParagraphStyle(
            "cover_sub",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=12,
            leading=17,
            textColor=MUTED,
            alignment=TA_CENTER,
            spaceAfter=6,
        ),
        "h1": ParagraphStyle(
            "h1",
            parent=base["Heading1"],
            fontName="Helvetica-Bold",
            fontSize=18,
            leading=22,
            textColor=NAVY,
            spaceBefore=4,
            spaceAfter=10,
        ),
        "h2": ParagraphStyle(
            "h2",
            parent=base["Heading2"],
            fontName="Helvetica-Bold",
            fontSize=13.5,
            leading=17,
            textColor=TEAL,
            spaceBefore=12,
            spaceAfter=6,
        ),
        "h3": ParagraphStyle(
            "h3",
            parent=base["Heading3"],
            fontName="Helvetica-Bold",
            fontSize=11.5,
            leading=15,
            textColor=NAVY,
            spaceBefore=8,
            spaceAfter=4,
        ),
        "body": ParagraphStyle(
            "body",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=10,
            leading=14,
            textColor=NAVY,
            alignment=TA_JUSTIFY,
            spaceAfter=7,
        ),
        "note": ParagraphStyle(
            "note",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=9.5,
            leading=13,
            textColor=NAVY,
            leftIndent=6,
            spaceAfter=8,
        ),
        "small": ParagraphStyle(
            "small",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=8.5,
            leading=11.5,
            textColor=NAVY,
        ),
        "th": ParagraphStyle(
            "th",
            parent=base["Normal"],
            fontName="Helvetica-Bold",
            fontSize=8.2,
            leading=11,
            textColor=WHITE,
        ),
        "td": ParagraphStyle(
            "td",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=8.2,
            leading=11,
            textColor=NAVY,
        ),
        "code": ParagraphStyle(
            "code",
            parent=base["Code"],
            fontName="Courier",
            fontSize=8,
            leading=11,
            textColor=NAVY,
            backColor=SOFT,
            leftIndent=4,
            rightIndent=4,
            spaceBefore=4,
            spaceAfter=8,
        ),
        "footer": ParagraphStyle(
            "footer",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=8,
            textColor=MUTED,
        ),
        "bullet": ParagraphStyle(
            "bullet",
            parent=base["Normal"],
            fontName="Helvetica",
            fontSize=10,
            leading=13.5,
            textColor=NAVY,
            leftIndent=8,
            spaceAfter=2,
        ),
    }
    return s


S = styles()


def bullets(items):
    return ListFlowable(
        [
            ListItem(Paragraph(item, S["bullet"]), leftIndent=12, bulletColor=ORANGE)
            for item in items
        ],
        bulletType="bullet",
        start="circle",
        leftIndent=16,
        spaceAfter=8,
    )


def callout(title, text, fill, border):
    data = [[Paragraph(f"<b>{title}</b><br/>{text}", S["note"])]]
    t = Table(data, colWidths=[170 * mm])
    t.setStyle(
        TableStyle(
            [
                ("BACKGROUND", (0, 0), (-1, -1), fill),
                ("BOX", (0, 0), (-1, -1), 0.8, border),
                ("LEFTPADDING", (0, 0), (-1, -1), 8),
                ("RIGHTPADDING", (0, 0), (-1, -1), 8),
                ("TOPPADDING", (0, 0), (-1, -1), 7),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 7),
            ]
        )
    )
    return t


def table(headers, rows, widths):
    head = [Paragraph(h, S["th"]) for h in headers]
    body = [[Paragraph(str(c), S["td"]) for c in row] for row in rows]
    t = Table([head] + body, colWidths=widths, repeatRows=1)
    style_cmds = [
        ("BACKGROUND", (0, 0), (-1, 0), NAVY),
        ("TEXTCOLOR", (0, 0), (-1, 0), WHITE),
        ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
        ("BACKGROUND", (0, 1), (-1, -1), WHITE),
        ("ROWBACKGROUNDS", (0, 1), (-1, -1), [WHITE, SOFT]),
        ("GRID", (0, 0), (-1, -1), 0.3, LINE),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("LEFTPADDING", (0, 0), (-1, -1), 5),
        ("RIGHTPADDING", (0, 0), (-1, -1), 5),
        ("TOPPADDING", (0, 0), (-1, -1), 5),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
    ]
    t.setStyle(TableStyle(style_cmds))
    return t


def header_footer(canvas, doc):
    canvas.saveState()
    canvas.setFillColor(ORANGE)
    canvas.rect(0, A4[1] - 6, A4[0], 6, fill=1, stroke=0)
    canvas.setFillColor(NAVY)
    canvas.rect(0, 0, A4[0], 14 * mm, fill=1, stroke=0)
    canvas.setFillColor(WHITE)
    canvas.setFont("Helvetica", 8)
    canvas.drawString(18 * mm, 6 * mm, "Flutter Course  ·  Final Project  ·  Food Delivery App")
    canvas.drawRightString(A4[0] - 18 * mm, 6 * mm, f"Page {doc.page}")
    canvas.restoreState()


def cover_page(canvas, doc):
    canvas.saveState()
    canvas.setFillColor(NAVY)
    canvas.rect(0, 0, A4[0], A4[1], fill=1, stroke=0)
    canvas.setFillColor(ORANGE)
    canvas.rect(0, A4[1] - 28 * mm, A4[0], 28 * mm, fill=1, stroke=0)
    canvas.setFillColor(TEAL)
    canvas.rect(0, 0, A4[0], 18 * mm, fill=1, stroke=0)
    canvas.setFillColor(WHITE)
    canvas.setFont("Helvetica-Bold", 11)
    canvas.drawCentredString(A4[0] / 2, A4[1] - 17 * mm, "FLUTTER COURSE  ·  FINAL PROJECT BRIEF")
    canvas.setFont("Helvetica", 9)
    canvas.drawCentredString(A4[0] / 2, 8 * mm, "Use this document with the Figma file and the Fake Restaurant API")
    canvas.restoreState()
    header_footer(canvas, doc)


def add_heading(story, text):
    story.append(Paragraph(text, S["h1"]))


def build():
    story = []

    story.append(Spacer(1, 55 * mm))
    story.append(Paragraph("STUDENT HANDOUT", S["cover_kicker"]))
    story.append(
        Paragraph(
            "Food Delivery App<br/>Final Project Documentation",
            ParagraphStyle(
                "ct",
                parent=S["cover_title"],
                textColor=WHITE,
                fontSize=30,
                leading=36,
            ),
        )
    )
    story.append(Spacer(1, 8 * mm))
    story.append(
        Paragraph(
            "Build a Flutter food-delivery client that follows the Figma UI,<br/>"
            "talks to the Fake Restaurant API, and uses the same Clean Architecture<br/>"
            "you practiced in the course project.",
            ParagraphStyle("cs", parent=S["cover_sub"], textColor=colors.HexColor("#E5E7EB")),
        )
    )
    story.append(Spacer(1, 18 * mm))
    meta = table(
        ["Item", "Value"],
        [
            ["Course", "Flutter"],
            ["Project type", "Final / capstone project"],
            ["UI source", "Food Delivery App UI Kit (Figma Community)"],
            ["Backend", "Fake Restaurant API (REST / JSON)"],
            ["Architecture", "Clean Architecture + Cubit + GetIt (same as course project)"],
            ["Base URL", "https://fakerestaurantapi.runasp.net"],
        ],
        [45 * mm, 115 * mm],
    )
    story.append(meta)
    story.append(PageBreak())

    # 1 Overview
    add_heading(story, "1. Project overview")
    story.append(
        Paragraph(
            "You will build a mobile food-delivery app in Flutter. Users register and sign in, "
            "browse restaurants and dishes, open a restaurant menu, add items to a cart, place an "
            "order, then review and manage their order history. The visual design comes from the "
            "Figma UI kit. All real data comes from the Fake Restaurant API.",
            S["body"],
        )
    )
    story.append(Paragraph("Official links (open these first)", S["h2"]))
    story.append(
        table(
            ["Resource", "URL"],
            [
                [
                    "Figma design",
                    "https://www.figma.com/design/1XfcAbRTl0PSyTANsOIOgY/Food-Delivery-App-UI-Kit-Food-App-Design-Food-Mobile-App-Delivery-UI--Community-?node-id=47-23",
                ],
                ["API docs", "https://fakerestaurantapi.runasp.net/Docs.html"],
                ["API GitHub (optional)", "Linked from the API docs site"],
            ],
            [40 * mm, 130 * mm],
        )
    )

    story.append(Paragraph("What “done” looks like", S["h2"]))
    story.append(
        bullets(
            [
                "A runnable Flutter app (Android and/or iOS emulator is enough).",
                "Clean Architecture folders like the course project: <b>core</b> + feature packages.",
                "Remote calls isolated in the data layer (Dio). UI never calls the API directly.",
                "Cubit (or Bloc) for each feature, registered with GetIt.",
                "Loading, empty, and error states on every network screen.",
                "Session persistence: after a successful login, the user stays signed in.",
                "A cart that can hold items from <b>one restaurant at a time</b>, then place a real API order.",
            ]
        )
    )

    # 2 Architecture
    add_heading(story, "2. Clean Architecture (same as the course project)")
    story.append(
        Paragraph(
            "Copy the structure you used in the course app. The difference is the data source: "
            "instead of Firebase Auth / Firestore you will use REST with Dio. Keep the same "
            "separation of layers so the UI does not know how JSON or HTTP works.",
            S["body"],
        )
    )
    story.append(Paragraph("Layers", S["h2"]))
    story.append(
        table(
            ["Layer", "Folder", "Responsibility", "Course equivalent"],
            [
                [
                    "Presentation",
                    "features/&lt;name&gt;/presentation",
                    "Screens, widgets, Cubit, UI state",
                    "AuthCubit, LoginScreen, widgets",
                ],
                [
                    "Domain",
                    "features/&lt;name&gt;/domain",
                    "Entities + abstract repository. No Flutter, no Dio.",
                    "UserEntity, AuthRepository",
                ],
                [
                    "Data",
                    "features/&lt;name&gt;/data",
                    "DTOs/models, remote service, repository implementation",
                    "UserModel, FirebaseAuthService, AuthRepoImpl",
                ],
                [
                    "Core",
                    "lib/core",
                    "DI, routing, theme, helpers, networking, shared widgets",
                    "get_it, AppRouter, AppColors, FirebaseResult",
                ],
            ],
            [28 * mm, 42 * mm, 55 * mm, 45 * mm],
        )
    )
    story.append(Paragraph("Required folder map", S["h2"]))
    story.append(
        Paragraph(
            "<font face='Courier' size='8'>"
            "lib/<br/>"
            "  core/<br/>"
            "    constants/          // base URL, keys, default error text<br/>"
            "    di/                 // GetIt registrations<br/>"
            "    helpers/            // extensions, session (save usercode)<br/>"
            "    networking/         // Dio factory, interceptors, ApiResult, safeApiCall<br/>"
            "    routing/            // routes + AppRouter<br/>"
            "    themes/             // colors, text styles from Figma<br/>"
            "    widgets/            // buttons, text fields, loaders<br/>"
            "  features/<br/>"
            "    auth/               // register, login, session, logout<br/>"
            "    restaurants/        // list, filter, details<br/>"
            "    menu/               // restaurant menu + item search<br/>"
            "    cart/               // local cart (no cart API exists)<br/>"
            "    orders/             // place order, history, details, cancel<br/>"
            "    profile/            // email, change password, delete account<br/>"
            "</font>",
            S["body"],
        )
    )
    story.append(Paragraph("Dependency direction (do not break this)", S["h2"]))
    story.append(
        bullets(
            [
                "Presentation → Domain (Cubit talks to the <b>abstract</b> repository).",
                "Data → Domain (models map to entities; impl implements the abstract repo).",
                "Domain depends on <b>nothing</b> from Flutter, Dio, or JSON annotations if you can avoid it.",
                "Core networking is shared. Feature services use the shared Dio client.",
            ]
        )
    )
    story.append(Paragraph("Suggested packages (stay close to the course stack)", S["h2"]))
    story.append(
        table(
            ["Package", "Why"],
            [
                ["flutter_bloc / bloc", "Cubit + states, same as AuthCubit"],
                ["get_it", "Dependency injection, same as setupGetIt()"],
                ["freezed + freezed_annotation", "Union states (loading / success / failure)"],
                ["json_annotation + json_serializable + build_runner", "DTO fromJson / toJson"],
                ["dio + pretty_dio_logger", "HTTP client + request logs"],
                ["shared_preferences or flutter_secure_storage", "Persist usercode after login"],
                ["cached_network_image", "Menu item photos from imageUrl"],
                ["equatable (optional)", "Value equality for entities"],
            ],
            [70 * mm, 100 * mm],
        )
    )
    story.append(Spacer(1, 3 * mm))
    story.append(
        callout(
            "Replace Firebase pieces with HTTP pieces",
            "FirebaseResult → ApiResult&lt;T&gt; with success/failure. "
            "safeFirebaseCall → safeApiCall that catches DioException and maps it to an error model. "
            "FirebaseAuthService → AuthRemoteService using Dio. "
            "getCurrentUser() → read the stored usercode + email from local session.",
            colors.HexColor("#ECFDF5"),
            TEAL,
        )
    )

    # 3 Data models
    add_heading(story, "3. Domain models you must implement")
    story.append(
        Paragraph(
            "Create entities in domain and JSON models in data. Field names below match the API. "
            "Prices are decimal numbers (treat them as INR in the UI).",
            S["body"],
        )
    )
    story.append(
        table(
            ["Entity", "Fields", "Notes"],
            [
                [
                    "Restaurant",
                    "restaurantID, restaurantName, address, type, parkingLot",
                    "type is the cuisine / category",
                ],
                [
                    "MenuItem",
                    "itemID, itemName, itemDescription, itemPrice, restaurantName, restaurantID, imageUrl",
                    "Encode spaces in imageUrl before loading",
                ],
                [
                    "UserSession",
                    "userEmail, usercode (API key)",
                    "Password must never be stored after login",
                ],
                [
                    "CartLine",
                    "itemName, quantity, itemPrice, restaurantID, imageUrl?",
                    "Local only. Place-order body needs itemName + quantity",
                ],
                [
                    "MasterOrder",
                    "masterID, userID, usercode, restaurantID, grandtotal",
                    "History list item",
                ],
                [
                    "OrderLine",
                    "orderID, userID, itemName, quantity, itemPrice, totalPrice, masterID",
                    "Details of one master order",
                ],
            ],
            [32 * mm, 78 * mm, 60 * mm],
        )
    )

    # 4 Screens
    add_heading(story, "4. Screens — what to build and what each screen does")
    story.append(
        Paragraph(
            "Implement these screens in the Figma style. Each row tells you the user goal, the "
            "API (if any), and the expected behavior. Screens marked <b>Required</b> are graded. "
            "Screens marked <b>UI only</b> may exist in Figma but have no matching backend — "
            "build them only if you have time, with local mock data.",
            S["body"],
        )
    )

    story.append(Paragraph("4.1 Authentication &amp; session", S["h2"]))
    story.append(
        table(
            ["Screen", "What the student builds", "API / data", "Grade"],
            [
                [
                    "Splash",
                    "Short branded splash. If a usercode is saved, go to Home. Otherwise go to Login (or Onboarding once).",
                    "Local session only",
                    "Required",
                ],
                [
                    "Onboarding (1–3 pages)",
                    "Optional pager that matches Figma. Skip / Get started → Login.",
                    "None",
                    "Recommended",
                ],
                [
                    "Sign up",
                    "Email + password (+ confirm password in UI). Validate empty fields like the course AuthCubit. On success save usercode and open Home.",
                    "POST /api/User/register",
                    "Required",
                ],
                [
                    "Login",
                    "Email + password. On success save usercode + email. Show API error if credentials are wrong.",
                    "GET /api/User/getusercode",
                    "Required",
                ],
            ],
            [32 * mm, 68 * mm, 40 * mm, 30 * mm],
        )
    )

    story.append(Paragraph("4.2 Home, search, and discovery", S["h2"]))
    story.append(
        table(
            ["Screen", "What the student builds", "API / data", "Grade"],
            [
                [
                    "Home",
                    "Header (greeting + location can be static or from restaurant.address). Horizontal cuisine chips built from unique restaurant.type values. Vertical list/grid of restaurants (name, type, address, parking badge). Pull to refresh. Bottom navigation: Home, Search, Orders, Profile (Cart can be an icon on Home).",
                    "GET /api/Restaurant",
                    "Required",
                ],
                [
                    "Category / filter",
                    "Tapping a cuisine chip filters the list. Clearing the chip shows all restaurants.",
                    "GET /api/Restaurant?category={type}",
                    "Required",
                ],
                [
                    "Search",
                    "One search field. Search restaurants by name and/or address. Also search dishes by item name and show which restaurant they belong to. Tapping a dish opens that restaurant menu (or item sheet).",
                    "GET /api/Restaurant?name=&amp;address=  and  GET /api/Restaurant/items?ItemName=",
                    "Required",
                ],
                [
                    "Sort dishes",
                    "On Search or Menu, allow sort by price low→high / high→low.",
                    "sortbyprice=asc|desc",
                    "Required",
                ],
            ],
            [32 * mm, 68 * mm, 40 * mm, 30 * mm],
        )
    )

    story.append(Paragraph("4.3 Restaurant, menu, and item", S["h2"]))
    story.append(
        table(
            ["Screen", "What the student builds", "API / data", "Grade"],
            [
                [
                    "Restaurant details",
                    "Hero header with name, cuisine (type), full address, parkingLot yes/no. Then the menu list.",
                    "GET /api/Restaurant/{id}  +  GET /api/Restaurant/{id}/menu",
                    "Required",
                ],
                [
                    "Menu list",
                    "Each row: image, itemName, short description, price, add button. Empty menu state if the restaurant has no items.",
                    "Same menu endpoint. Optional ?sortbyprice=",
                    "Required",
                ],
                [
                    "Item details",
                    "Large image, name, description, price, quantity stepper, Add to cart. If Figma has extras (size, spicy), keep them visual only — the API only stores itemName + quantity.",
                    "Item object already loaded from menu/items",
                    "Required",
                ],
            ],
            [32 * mm, 68 * mm, 40 * mm, 30 * mm],
        )
    )

    story.append(Paragraph("4.4 Cart and checkout", S["h2"]))
    story.append(
        Paragraph(
            "There is <b>no cart endpoint</b>. The cart lives in memory + optional local cache "
            "(shared preferences). When the user places the order you send the cart lines to "
            "Make Order.",
            S["body"],
        )
    )
    story.append(
        table(
            ["Screen", "What the student builds", "API / data", "Grade"],
            [
                [
                    "Cart",
                    "List of lines with qty + / −, remove, per-line total, grand total. Empty cart illustration. If the user adds an item from a different restaurant, ask to replace the cart.",
                    "Local CartCubit",
                    "Required",
                ],
                [
                    "Checkout",
                    "Summary of items + grand total. Delivery address can be a local text field (API does not store address on the order). Confirm button calls Make Order with the current restaurantID.",
                    "POST /api/Order/{restaurantId}/makeorder?apikey=",
                    "Required",
                ],
                [
                    "Payment UI",
                    "Figma may show cards / wallets. Do <b>not</b> integrate a real gateway. A fake “Pay &amp; place order” button that then calls Make Order is enough.",
                    "None (then Make Order)",
                    "UI only / optional",
                ],
            ],
            [32 * mm, 68 * mm, 40 * mm, 30 * mm],
        )
    )

    story.append(Paragraph("4.5 Orders and profile", S["h2"]))
    story.append(
        table(
            ["Screen", "What the student builds", "API / data", "Grade"],
            [
                [
                    "Orders list",
                    "All master orders for the signed-in usercode. Show masterID, restaurantID (resolve name if you already fetched restaurants), grandtotal. Empty state for new users.",
                    "GET /api/Order?apikey=",
                    "Required",
                ],
                [
                    "Order details",
                    "Lines: itemName, qty, itemPrice, totalPrice. Show grand total. Actions: delete one line, or cancel the whole master order (with confirm dialog).",
                    "GET /api/Order/{masterId}?apikey=  DELETE line or master",
                    "Required",
                ],
                [
                    "Order tracking",
                    "Figma tracking / map screen. The API has no status or courier. If you build it, fake steps (Placed → Preparing → Done) locally after checkout.",
                    "Local mock only",
                    "UI only / optional",
                ],
                [
                    "Profile",
                    "Show email. Change password. Logout (clear session → Login). Optional: delete account.",
                    "PUT /api/User/{usercode}  DELETE /api/User/{usercode}",
                    "Required (logout + show email). Password/delete recommended.",
                ],
            ],
            [32 * mm, 68 * mm, 40 * mm, 30 * mm],
        )
    )

    story.append(Paragraph("Suggested navigation graph", S["h2"]))
    story.append(
        Paragraph(
            "<font face='Courier' size='8'>"
            "Splash → (session? Home : Login)<br/>"
            "Login ↔ SignUp → Home<br/>"
            "Home → RestaurantDetails → ItemDetails → Cart → Checkout → OrderDetails<br/>"
            "Home → Search → RestaurantDetails / ItemDetails<br/>"
            "BottomNav: Home | Search | Orders | Profile<br/>"
            "Orders → OrderDetails<br/>"
            "</font>",
            S["body"],
        )
    )

    # 5 User stories
    add_heading(story, "5. User stories (acceptance behavior)")
    stories = [
        "<b>Register.</b> New email + password creates an account, returns a usercode, and opens Home.",
        "<b>Login.</b> Existing email + password returns the same usercode. Invalid credentials show a readable error, not a crash.",
        "<b>Session.</b> Killing and reopening the app keeps the user on Home if usercode is stored.",
        "<b>Browse.</b> Home shows the live restaurant list from the API (currently ~31 restaurants).",
        "<b>Filter.</b> Choosing “Biryani” (or any type) shows only that cuisine.",
        "<b>Open restaurant.</b> Details + menu load for that restaurantID. Images use imageUrl.",
        "<b>Search food.</b> Query “fish” finds items such as Fish Amritsari and Fish Curry.",
        "<b>Cart rules.</b> Qty updates the line total. Mixed restaurants are blocked or replace the cart.",
        "<b>Place order.</b> Checkout sends menuDTO and then shows the new master order / grandTotal.",
        "<b>History.</b> Orders tab lists master orders for this usercode only.",
        "<b>Cancel.</b> User can delete a single line or the whole master order, then the list refreshes.",
        "<b>Logout.</b> Clears usercode and returns to Login.",
    ]
    story.append(bullets(stories))

    # 6 API
    add_heading(story, "6. API guide for students")
    story.append(
        Paragraph(
            "Base URL: <b>https://fakerestaurantapi.runasp.net</b>. All bodies are JSON. "
            "Send <font face='Courier'>Content-Type: application/json</font> on POST/PUT. "
            "Official examples: https://fakerestaurantapi.runasp.net/Docs.html",
            S["body"],
        )
    )
    story.append(
        callout(
            "Critical: usercode is the API key",
            "After register or getusercode you receive usercode (a GUID). Every Order URL needs "
            "?apikey={usercode}. User update/delete uses the usercode in the path. "
            "Never hard-code another student’s key.",
            colors.HexColor("#FEF3C7"),
            colors.HexColor("#D97706"),
        )
    )

    story.append(Paragraph("6.1 Restaurants &amp; menu (public, no API key)", S["h2"]))
    story.append(
        table(
            ["Method", "Endpoint", "Query / body", "Use in the app"],
            [
                ["GET", "/api/Restaurant", "—", "Home list"],
                ["GET", "/api/Restaurant", "category=Parsi Cuisine", "Cuisine chip filter"],
                [
                    "GET",
                    "/api/Restaurant",
                    "name=Paradise Biryani&amp;address=hyderabad",
                    "Restaurant search (address is contains / substring)",
                ],
                ["GET", "/api/Restaurant/{id}", "—", "Restaurant header (id e.g. 4 = Bawarchi)"],
                ["GET", "/api/Restaurant/{id}/menu", "sortbyprice=asc|desc", "Menu of one restaurant"],
                ["GET", "/api/Restaurant/items", "—", "All dishes (optional discover section)"],
                ["GET", "/api/Restaurant/items", "ItemName=fish", "Food search"],
                ["GET", "/api/Restaurant/items", "sortbyprice=asc|desc", "Sort all dishes"],
            ],
            [18 * mm, 52 * mm, 52 * mm, 48 * mm],
        )
    )
    story.append(Paragraph("Restaurant JSON", S["h3"]))
    story.append(
        Paragraph(
            '{"restaurantID": 4, "restaurantName": "Bawarchi", '
            '"address": "Hyderabad, RTC Cross Road, Telangana", '
            '"type": "Biryani", "parkingLot": true}',
            S["code"],
        )
    )
    story.append(Paragraph("Menu item JSON", S["h3"]))
    story.append(
        Paragraph(
            '{"itemID": 91, "itemName": "Haleem", '
            '"itemDescription": "Rich and creamy stew made with lentils, wheat, and slow-cooked meat.", '
            '"itemPrice": 220.0, "restaurantName": "Pista House", "restaurantID": 5, '
            '"imageUrl": "https://fakerestaurantapi.runasp.net/images/haleem.jpg"}',
            S["code"],
        )
    )
    story.append(
        Paragraph(
            "Cuisine values you will see include: Biryani, Mughlai, South Indian, Rajasthani, "
            "Bengali Cuisine, Gujarati, Multi-cuisine, Modern Indian, Hyderabadi Cuisine, Thai, "
            "Parsi Cuisine, North Indian, Seafood, Fine Dining, Brewery, and others. Build chips "
            "from the live list — do not hard-code a stale set.",
            S["body"],
        )
    )

    story.append(Paragraph("6.2 User (auth)", S["h2"]))
    story.append(
        table(
            ["Method", "Endpoint", "Body / query", "Use in the app"],
            [
                [
                    "POST",
                    "/api/User/register",
                    '{"userEmail":"...", "password":"..."}',
                    "Sign up — response includes usercode",
                ],
                [
                    "GET",
                    "/api/User/getusercode",
                    "UserEmail=&amp;Password=",
                    "Login — returns { usercode }",
                ],
                ["GET", "/api/User", "—", "Optional debug only. Do not show other users’ passwords in the UI."],
                [
                    "PUT",
                    "/api/User/{usercode}",
                    "JSON string of the new password",
                    "Change password on Profile",
                ],
                ["DELETE", "/api/User/{usercode}", "—", "Delete account, then clear session"],
            ],
            [18 * mm, 48 * mm, 52 * mm, 52 * mm],
        )
    )
    story.append(
        Paragraph(
            "Register response: {\"userEmail\":\"...\",\"password\":\"...\",\"usercode\":\"6f3d1852-...\"}. "
            "Login response: {\"usercode\":\"cbc4ecf6-...\"}. Save email yourself; getusercode does not echo it.",
            S["body"],
        )
    )

    story.append(Paragraph("6.3 Orders (protected — apikey required)", S["h2"]))
    story.append(
        table(
            ["Method", "Endpoint", "Body / query", "Use in the app"],
            [
                ["GET", "/api/Order?apikey={usercode}", "—", "Orders tab (master orders)"],
                [
                    "GET",
                    "/api/Order/{masterId}?apikey={usercode}",
                    "—",
                    "Order details (line items)",
                ],
                [
                    "POST",
                    "/api/Order/{restaurantId}/makeorder?apikey={usercode}",
                    "See body below",
                    "Checkout confirm",
                ],
                [
                    "DELETE",
                    "/api/Order/master/{masterId}?apikey={usercode}",
                    "—",
                    "Cancel whole order",
                ],
                [
                    "DELETE",
                    "/api/Order/{orderId}?apikey={usercode}",
                    "—",
                    "Remove one line from an order",
                ],
            ],
            [18 * mm, 72 * mm, 32 * mm, 48 * mm],
        )
    )
    story.append(Paragraph("Make-order request body", S["h3"]))
    story.append(
        Paragraph(
            '{"menuDTO":[{"itemName":"Kofta Curry","quantity":2},'
            '{"itemName":"Sheer Korma","quantity":2}]}',
            S["code"],
        )
    )
    story.append(
        Paragraph(
            "Response shape: {\"fullorder\":[ {orderID, userID, itemName, quantity, itemPrice, "
            "totalPrice, masterID}, ... ], \"grandTotal\": 900 }. "
            "A <b>master order</b> is one checkout. Each cart line becomes a single order row "
            "under the same masterID.",
            S["body"],
        )
    )
    story.append(Paragraph("Master-order list item", S["h3"]))
    story.append(
        Paragraph(
            '{"masterID": 4, "userID": "...", "usercode": "...", '
            '"restaurantID": 1, "grandtotal": 2750}',
            S["code"],
        )
    )

    story.append(Paragraph("6.4 Endpoints you must NOT treat as real features", S["h2"]))
    story.append(
        table(
            ["Endpoint", "Why"],
            [
                [
                    "POST /api/Restaurant",
                    "Docs say the object is not saved. Do not build “add restaurant” as a graded feature.",
                ],
                [
                    "POST /api/Restaurant/{id}/additem",
                    "Same: not persisted. Do not build a merchant “add dish” flow.",
                ],
            ],
            [70 * mm, 100 * mm],
        )
    )

    story.append(Paragraph("6.5 Networking rules (course style)", S["h2"]))
    story.append(
        bullets(
            [
                "One Dio instance in core/networking with baseUrl and timeouts (e.g. 20s).",
                "PrettyDioLogger in debug only.",
                "Wrap every call in safeApiCall so Cubits receive ApiResult.success or failure.",
                "Map HTTP errors and timeouts to a short user message (like ApiConstants.defaultError).",
                "Encode image URLs: some files contain spaces (mutton biryani.jpg).",
                "itemName in makeorder must match the menu spelling exactly.",
                "GET /api/Restaurant/{id} returns a <b>single object</b>, not a list (the HTML docs sample is outdated).",
                "Do not log passwords in production builds.",
            ]
        )
    )

    # 7 Implementation plan
    add_heading(story, "7. Suggested build order")
    story.append(
        table(
            ["Week / step", "Deliverable"],
            [
                [
                    "1. Project skeleton",
                    "Flutter app, theme from Figma, routing, GetIt, Dio, ApiResult, empty feature folders",
                ],
                [
                    "2. Auth",
                    "Register, login, splash session, logout — same Cubit pattern as the course",
                ],
                [
                    "3. Restaurants",
                    "Home list, category chips, restaurant details header",
                ],
                [
                    "4. Menu &amp; search",
                    "Menu list + images, item details, search items, sort by price",
                ],
                [
                    "5. Cart",
                    "Local cart, restaurant lock, qty, totals",
                ],
                [
                    "6. Orders",
                    "Make order, history, details, delete line / delete master",
                ],
                [
                    "7. Polish",
                    "Figma spacing, skeleton loaders, empty/error, profile password, README",
                ],
            ],
            [40 * mm, 130 * mm],
        )
    )

    # 8 UI
    add_heading(story, "8. UI implementation notes")
    story.append(
        bullets(
            [
                "Extract colors and text styles from Figma into core/themes (like AppColors in the course app).",
                "Reuse widgets: primary button, input field, restaurant card, food tile, price text, bottom nav.",
                "Use CachedNetworkImage with a placeholder and error icon for every dish photo.",
                "Show Skeletonizer (or your own shimmer) while lists load — you already used this on splash in the course project.",
                "SafeArea + scroll views: Figma frames are iPhone sized; test a small Android emulator too.",
                "Bottom navigation should keep tab state (IndexedStack or similar).",
                "Currency: format itemPrice as a currency (e.g. ₹220). The API does not send a currency code.",
            ]
        )
    )

    # 9 Grading
    add_heading(story, "9. Grading checklist")
    story.append(
        table(
            ["Area", "What instructors will check", "Weight (guide)"],
            [
                ["Architecture", "Layers, no API calls from widgets, GetIt, Cubit states", "25%"],
                ["Auth &amp; session", "Register, login, persist usercode, logout", "15%"],
                ["Restaurants &amp; menu", "Live list, filter, details, images, search, sort", "20%"],
                ["Cart &amp; order", "Local cart rules + successful makeorder + history + delete", "20%"],
                ["UI fidelity", "Looks like the Figma kit: layout, type, colors, empty/error", "15%"],
                ["Code quality", "Naming, error handling, no crashes, short README", "5%"],
            ],
            [40 * mm, 100 * mm, 30 * mm],
        )
    )

    # 10 README
    add_heading(story, "10. What to submit")
    story.append(
        bullets(
            [
                "Git repository (or zip) of the Flutter project.",
                "README: how to run, test account email you created, and a 1-paragraph architecture note.",
                "Do not commit secrets. usercode is per user and is created at runtime.",
            ]
        )
    )

    story.append(Spacer(1, 8 * mm))
    story.append(
        callout(
            "Remember",
            "The Figma file is the look. The API is the truth for data. Clean Architecture is the "
            "rule for code. If those three stay aligned, the project is complete.",
            CREAM,
            ORANGE,
        )
    )

    doc = SimpleDocTemplate(
        str(OUT),
        pagesize=A4,
        leftMargin=18 * mm,
        rightMargin=18 * mm,
        topMargin=16 * mm,
        bottomMargin=20 * mm,
        title="Flutter Final Project — Food Delivery App",
        author="Flutter Course",
        subject="Student documentation: Figma screens, Clean Architecture, Fake Restaurant API",
    )
    doc.build(story, onFirstPage=cover_page, onLaterPages=header_footer)
    print(f"Wrote {OUT}")


if __name__ == "__main__":
    build()
