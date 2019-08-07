library(shiny)
library(shinydashboard)
library(DT)
library(png)
library(readxl)
library(ggplot2)
library(cluster)
library(dplyr)

shinyUI(
  dashboardPage(
    skin = "green",
    dashboardHeader(title = "Sistem Informasi Kesehatan Kota Bandung", titleWidth = 420),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Beranda", tabName = "home", icon = icon("home")),
        menuItem("Definisi",tabName = "definisi", icon = icon("angle_down"),
                 menuSubItem("K-Means Clustering",
                             tabName = "pengertian",
                             icon=icon("book-reader")),
                 menuSubItem("Demam Berdarah Dengue",
                             tabName = "dbd",
                             icon=icon("book-reader")),
                 menuSubItem("Diare",
                             tabName = "diare",
                             icon=icon("book-reader")),
                 menuSubItem("TB BTA+",
                             tabName="tb",
                             icon=icon("book-reader"))),
        menuItem("Pengujian", tabName = "kmeans", icon = icon("database")),
        menuItem("Exploratory Data Analysis",tabName = "explore",icon = icon("database"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "home",
          sidebarLayout(
            sidebarPanel(
              br(),
              br(),
              h3("Sistem Informasi Dinas Kesehatan Kota Bandung"),
              p(
                "Jl. Supratman No. 73",
                "Cibeunying Kaler, Kota Bandung, Jawa Barat 40122"
              ),
              p("Telepon  : (022) 872-44572"),
              p("Email    : dinaskesehatankotabdg@gmail.com"),
              br(),
              br(),
              br()
            ), #sidebarpanel
            mainPanel(
              width = 8,
              h1(strong("Sistem Informasi Dinas Kesehatan Kota Bandung")),
              p(
                "Kesehatan menurut Kementerian Kesehatan yang ditulis didalam UU No. 23 Tahun 1992  ",
                "adalah keadaan normal dan sejahtera anggota tubuh, sosial, dan jiwa pada seseorang
                yang dapat melakukan aktifitas tanpa gangguan. ",
                "Untuk menyelenggarakan pendidikan yang
                bermutu diperlukan biaya yang cukup besar. Oleh karena itu, bagi setiap peserta didik
                pada setiap satuan pendidikan berhak mendapatkan biaya pendidikan bagi mereka yang
                orang tuanya tidak mampu membiayai pendidikannya, dan berhak mendapatkan beasiswa
                bagi mereka yang berprestasi."
              ),
              h2("Hak Kesehatan"),
              p("Hak setiap warga Indonesia memperoleh kesehatan
                telah dijamin berdasarkan Undang-Undang Dasar 1945, Undang-Undang Nomor 36
                tahun 2009 tentang kesehatan, dan Undang-Undang Nomor 39 Tahun 1999 tentang Hak
                Asasi Manusia dan Konvenan Internasional tentang Hak Ekonomi, Sosial, dan Budaya
                yang telah diratifikasi oleh Undang-Undang Nomor 12 Tahun 2005. "),
              p("Adapun hak-hak kesehatan yang dapat diperoleh masyarakat adalah sebagai berikut:"),
              p("1. Hak memperoleh akses atas sumber daya di bidang kesehatan;"),
              p("2. Hak memperoleh pelayanan kesehatan yang aman, bermutu, dan terjangkau;"),
              p("3. Berhak secara mandiri dan bertanggung jawab menentukan sendiri pelayanan
                kesehatan yang diperlukan bagi dirinya;"),
              p("4. Berhak mendapatkan lingkungan yang sehat bagi pencapaian derajat kesehatan;"),
              p("5. Berhak mendapatkan informasi dan edukasi tentang kesehatan yang seimbang
                pendidikan kepada peserta didik yang orang tua atau walinya tidak mampu
                dan bertanggung jawab.")
              ) #mainPanel
              ) #sidebarlayout
              ), #tabitem
        tabItem(
          tabName = "pengertian",
          h2("Pengertian K-Means Clustering"),
          p(
            "K-Means Clustering adalah salah satu metode clustering yang umum digunakan dan sederhana",
            "K-Means bekerja mencari partisi terdekat dengan titik pusat yang telah ditentukan secara
            random atau acak"
          ),
          h2("Proses K-Means:"),
          br(),
        fluidRow(
          column(width = 6, align = "center",
            img(src = "fchart.png", height = 724, width = 567, align ="center")),
          column(width = 6,
            box(
              br(),
            p("1. Tentukan berapa banyak data yang harus dibagi;"),
            p("2. Alokasikan data yang telah dikumpulkan kedalam cluster secara random;"),
            p("3. Tentukan pusat cluster (centroid) dan alokasikan data kemasing-masing centroid terdekat;"),
            p("4. Perbaharui lokasi centroid ke nilai baru centroid;"),
            p("5. Ulangi langkah 3 dan 4 hingga clustering menjadi terpusat ke satu
              centroid dan stabil (sudah tidak ada perpindahan data);")
          )))),
        tabItem(
          tabName = "dbd",
            h2("Demam Berdarah Dengue (DBD)"),
            p(
             "Demam Berdarah Dengue (DBD) adalah penyakit infeksi yang disebabkan oleh salah satu
              dari 4 virus dengue berbeda dan ditularkan melalui nyamuk terutama Aedes aegypti dan
              Aedes albopictus yang ditemukan didaerah tropis dan subtropis"
                ),
             br(),
             br(),
            fluidRow(
              column( width = 12, align = "center",
                img(scr = "dbd.png", height = 150, width = 200)),
              br(),
              hr(),
              br(),
              column(width = 12,
                box(
                  br(),
                  p(
                  "Menurut Profile Kesehatan pada tahun 2017 yang dikeluarkan oleh Dinas Kesehatan
                   Kota Bandung. Angka insiden DBD Kota Bandung cukup meningkat pada tahun 2014
                   hingga tahun 2016, kemudian mengalami penurunan di tahun 2017.")
                        )))),
        tabItem(
          tabName = "diare",
          h1("Diare"),
          fluidRow(
          column(width = 12, align = "center",
                 img(src="diare.png", height = 260, width = 340)),
          br(),
          hr(),
          br(),
          column( width = 12,
            box(
              br(
                p(
                  "Diare mempunyai hubungan erat dengan perilaku sehat pada masing-masing individu.
                  Diare sendiri sering menyerang bayi, balita, dan orang dewasa. Menurut Profile
                  Kesehatan Kota Bandung tahun 2017 kecamatan Bandung Wetan mendapatkan kecamatan tertinggi sebesar
                  140,79%.")
              ))
          )
        )),
        tabItem(
          tabName = "tb",
          h1("TB BTA+"),
          fluidRow( 
            column( width = 12, align = "center",
              img(scr="tb.png", height=260, width=340)),
            br(),
            hr(),
            br(),
            column( width = 12,
                   box(
                     br(),
                     p(
                       "TB adalah penyakit infeksi menular yang disebabkan oleh bakteri Mycobacterium
                       tuberculosis yang dapat menyerang berbagai organ, terutama paru-paru. Jenis-jenis TB paru: "
                     ),
                     p("1. TB Sensitif"),
                     p("TB sensitif adalah TB pada tahap awal yang membutuhkan waktu 6 bulan untuk penyembuhan, dimana
                       TB BTA+ termasuk kedalam TB sensitif. TB BTA+ berasal dari kata Tuberculosis Basil Tahan Asam 
                       yang dibutuhkan dalam proses pemeriksaan awal seseorang terkena TB atau tidak"),
                     br(),
                     br(),
                     p("2. TB Resisten"),
                     p(
                       "TB Resisten terjadi jika seseorang telah melewati masa pengobatan selama 6 bulan namun
                       masih terdapat virus TB yang resisten terhadap obat."
                     )
                   ))
          )
          
        ),
        tabItem(
          tabName = "kmeans",
          fluidRow(
            tabBox(
              width = 12,
              fileInput("path_df_raw",
                        "Unggah file(.xlsx)",
                        multiple = TRUE,
                        accept = c(
                          "text/xlsx",
                          "text/extensible-stylesheet-language, text/plain",
                          ".xlsx"
                        )
              ),
              helpText("File maksimal 5MB")
            ),
            tabBox(
              width = 12,
              tabPanel(
                "Data Uji",
                br(),
                DT::dataTableOutput("df_raw")
              ),
              tabPanel(
                "K-means",
                br(),
                sidebarLayout(
                  sidebarPanel(
                    selectInput("var1",
                                "Pilih Variabel 1",
                                choices = NULL
                    ), #selectinput
                    selectInput("var2",
                                "Pilih Variabel 2",
                                choices = NULL
                    ), #selectinput
                    numericInput("n_clusters",
                                 "Berapa Banyak Cluster:",
                                 value = 2,
                                 min = 2,
                                 max = 9,
                                 step = 1
                    ),
                    actionButton(
                      "analyse",
                      "Analisis"
                    )
                  ),
                  mainPanel(
                    plotOutput("plot_kmeans"),
                    downloadButton("download_plot","Download Hasil Plotting"),
                    br(),
                    hr(),
                    br(),
                    DT::dataTableOutput("df_kmeans")) #mainpanel
                ) #sidebarlayout
              )#tabpanelkmeans
            ) #tabbox
          ) #fluidroww
        ), #tabitem
      tabItem(tabName = "explore",
              fluidRow(
                tabBox(id="idexplore", width = 20,
                       mainPanel(
                         tabsetPanel(
                           tabPanel("Explory Data",
                                    verbatimTextOutput("tableexplore"))
                         )
                       ))
              )) 
          ) #tabitems
          ) #dashboardbody
    ) #dashboardpage
  ) #shinyUI
