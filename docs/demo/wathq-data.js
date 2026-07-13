/* =========================================================================
   وضّح — الجدول المرجعي للتجار (wathq-data.js)
   -------------------------------------------------------------------------
   كل تاجر إما:
   - source: "wathq"  → بيانات حقيقية مسحوبة من واثق (fullinfo)، حقول الهوية
     التجارية فقط. بيانات الأفراد (المدراء/التواصل) محذوفة قبل التخزين عمدًا.
   - source: "seed"   → صف أولي بانتظار السحبة الرسمية؛ يظهر في الواجهة
     بشارة "قيد التوثيق الحكومي" بدل شارة التوثيق الخضراء.

   لإضافة تاجر جديد بعد سحبه من واثق: انسخ من استجابة fullinfo الحقول
   المذكورة أدناه فقط، وأضف aliases (الأشكال المتوقعة في كشف الحساب).
   ========================================================================= */

const WATHQ_MERCHANTS = [

  /* --- سجل حقيقي من واثق (سُحب عبر GET /fullinfo — بيئة الإنتاج) --- */
  {
    id: "addresscafe",
    displayName: "أدرس كافيه",
    displayBranch: "مقهى — الرياض",
    legalName: "شركة عنوان القهوة للتجارة",
    aliases: [
      "address cafe", "address cafe trd", "address cafe trd co",
      "address cafe co", "addresscafe", "عنوان القهوة", "ادرس كافيه"
    ],
    crNationalNumber: "7001775498",
    crNumber: "1010307349",
    status: "نشط",
    city: "الرياض",
    entityForm: "شركة مساهمة",
    hasEcommerce: true,
    issueDateGregorian: "2011-04-20",
    activities: [
      { code: "563011", name: "محلات تقديم المشروبات (الكوفي شوب)" },
      { code: "107911", name: "تحميص البن أو طحنه أو تعبئته" },
      { code: "463053", name: "البيع بالجملة لمنتجات القهوة والشاي" }
    ],
    categoryLabel: "مقاهي",
    explanation:
      "هذه عملية شراء من أدرس كافيه. الاسم الظاهر في كشفك هو الاسم القانوني " +
      "المسجل لدى وزارة التجارة، وغالبًا يختلف عن الاسم التجاري المعروف للمحل.",
    userMessage: null, // يُولَّد سؤال عام تلقائيًا
    source: "wathq"
  },

  /* --- صفوف أولية بانتظار السحبة الرسمية من واثق --- */
  {
    id: "apple",
    displayName: "آبل",
    displayBranch: "خدمات وتطبيقات إلكترونية",
    legalName: "Apple Distribution International",
    aliases: [
      "apple com bill", "apple.com/bill", "apple com", "itunes com",
      "apple services", "ابل كوم بيل", "آبل"
    ],
    crNationalNumber: null,
    crNumber: null,
    status: null,
    city: null,
    entityForm: null,
    hasEcommerce: true,
    issueDateGregorian: null,
    activities: [{ code: "5818", name: "خدمات رقمية واشتراكات تطبيقات" }],
    categoryLabel: "خدمات وتطبيقات إلكترونية",
    explanation:
      "هذه عملية شراء أو تجديد اشتراك من شركة آبل (مثل زيادة مساحة التخزين " +
      "أو اشتراك تطبيق). هذا النمط يتكرر شهريًا غالبًا — راقب تكراره في كشفك.",
    userMessage: "وشو تاجر (آبل كوم بيل) اللي خصم مني؟",
    source: "seed"
  },
  {
    id: "thamar",
    displayName: "سوبرماركت أسواق النخبة",
    displayBranch: "فرع حي الياسمين — الرياض",
    legalName: "شركة ثمار التنمية للتجارة",
    aliases: [
      "thamar al-tanmiya trading co", "thamar al tanmiya", "thamar altanmiya",
      "ثمار التنمية للتجارة", "شركة ثمار التنمية للتجارة", "ثمار التنمية"
    ],
    crNationalNumber: null,
    crNumber: null,
    status: null,
    city: "الرياض",
    entityForm: null,
    hasEcommerce: false,
    issueDateGregorian: null,
    activities: [{ code: "472101", name: "البيع بالتجزئة في السوبرماركت" }],
    categoryLabel: "نقاط بيع — مدى",
    explanation:
      "الاسم الظاهر في كشفك هو الاسم التجاري المسجل لجهاز نقاط البيع، " +
      "والجهاز يخص سوبرماركت أسواق النخبة (فرع حي الياسمين). " +
      "دُفع المبلغ عبر بطاقتك (مدى) بمسح الجهاز مباشرة.",
    userMessage: "مكتوب بالعملية (شركة ثمار التنمية للتجارة) ومخصوم 84 ريال، أنا ما رحت هالشركة!",
    source: "seed"
  },
  {
    id: "hungerstation",
    displayName: "هنقرستيشن",
    displayBranch: "توصيل طعام",
    legalName: "HungerStation LLC",
    aliases: ["hungerstation llc", "hungerstation", "هنقرستيشن", "هنقر ستيشن"],
    crNationalNumber: null,
    crNumber: null,
    status: null,
    city: "الرياض",
    entityForm: null,
    hasEcommerce: true,
    issueDateGregorian: null,
    activities: [{ code: "532013", name: "خدمات التوصيل عبر المنصات الإلكترونية" }],
    categoryLabel: "توصيل طعام",
    explanation:
      "هذه عملية طلب طعام عبر تطبيق هنقرستيشن. المبلغ يشمل قيمة الطلب " +
      "ورسوم التوصيل إن وجدت.",
    userMessage: null,
    source: "seed"
  },
  {
    id: "naft",
    displayName: "محطات نفط",
    displayBranch: "محطة وقود",
    legalName: "NAFT Services Co",
    aliases: ["naft services co", "naft services", "naft", "نفط"],
    crNationalNumber: null,
    crNumber: null,
    status: null,
    city: null,
    entityForm: null,
    hasEcommerce: false,
    issueDateGregorian: null,
    activities: [{ code: "473000", name: "بيع الوقود بالتجزئة في المحطات" }],
    categoryLabel: "محطة وقود",
    explanation: "هذه عملية تعبئة وقود من إحدى محطات نفط.",
    userMessage: null,
    source: "seed"
  },
  {
    id: "elixirbun",
    displayName: "إلكسير بن",
    displayBranch: "قهوة مختصة",
    legalName: "Elixir Bun Co",
    aliases: ["elixir bun co", "elixir bun", "elixirbun", "الكسير بن", "إلكسير بن"],
    crNationalNumber: null,
    crNumber: null,
    status: null,
    city: "الرياض",
    entityForm: null,
    hasEcommerce: false,
    issueDateGregorian: null,
    activities: [{ code: "563011", name: "محلات تقديم المشروبات (الكوفي شوب)" }],
    categoryLabel: "قهوة مختصة",
    explanation: "هذه عملية شراء من إلكسير بن — محمصة وقهوة مختصة.",
    userMessage: null,
    source: "seed"
  }
];
