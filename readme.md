# Wprowadzenie

Dokumentacja opisuje system monitorowania wydajności maszyn, który
składa się z kilku modułów:

-   **Backend:** Skrypty w Pythonie, odpowiedzialne za zbieranie,
    agregowanie oraz zapisywanie danych do bazy MySQL.

-   **Frontend:** Skrypty w JavaScript odpowiedzialne za wizualizację
    danych przy użyciu biblioteki Plotly.

-   **Moduły PHP:** Pliki odpowiedzialne za obsługę logiki aplikacji,
    konfigurację połączenia z bazą oraz generowanie interfejsu
    użytkownika.

# Wymagania systemowe

## Backend

-   Python 3.x

-   Biblioteki: `python-dotenv`, `schedule`, `paho-mqtt`, `pymysql`

-   Serwer bazy danych MySQL

## Frontend

-   Przeglądarka internetowa z obsługą JavaScript

-   Biblioteka `Plotly.js wersja 2.35.2`

-   Biblioteka `Bootstrap wersja 5.3.3`

## PHP

-   Serwer WWW z obsługą PHP w wersji 8.2.12 (np. Apache)

# Opis modułów i plików projektu

## Pliki Python

### `dailyDataInsert.py`

Skrypt `dailyDataInsert.py` odpowiada za:

-   Ładowanie zmiennych środowiskowych z pliku `.env` przy użyciu
    biblioteki `python-dotenv`.

-   Nawiązanie połączenia z bazą danych MySQL.

-   Wykonanie zapytania SQL, które agreguje dane z tabel `produkty` oraz
    `machine_status`. Obliczane są m.in. wskaźniki:

    -   **Jakość** – stosunek liczby produktów o statusie 1 do ogólnej
        liczby produktów.

    -   **Dostępność** – stosunek czasu pracy maszyny do całkowitego
        czasu.

    -   **Wydajność** – średnia wartość wskaźnika skalowania.

-   Wstawienie zagregowanych danych do tabeli `daily_data`.

-   Automatyczne uruchamianie zadania codziennie o godzinie 23:00 przy
    użyciu biblioteki `schedule`.

### `dataCollector.py`

Skrypt `dataCollector.py` odpowiada za:

-   Połączenie z brokerem MQTT (np. `broker.emqx.io`) oraz subskrypcję
    tematu `ZONE_01/#`.

-   Odbieranie wiadomości MQTT, parsowanie przesyłanego JSON-a oraz
    walidację formatu.

-   Wstawianie danych do bazy MySQL przy użyciu biblioteki `pymysql`.
    Operacje obejmują:

    -   Wstawianie alarmów do tabeli `alarmy`.

    -   Wstawianie eventów do tabeli `events`.

    -   Wstawianie informacji o produktach do tabeli `produkty`.

    -   Wstawianie statusu maszyny do tabeli `machine_status`.

    -   Dodawanie nowego rekordu do tabeli `maszyny` w przypadku, gdy
        maszyna nie istnieje w bazie.

-   Obsługę błędów związanych z niepoprawnym formatem JSON oraz błędami
    połączenia z bazą.

## Pliki JavaScript

### `index.js`

Plik `index.js` odpowiada za wizualizację danych na stronie internetowej
przy użyciu biblioteki Plotly. Główne funkcje to:

-   **createIndicator:** Tworzy wykres wskaźnikowy (gauge), prezentujący
    wartości OEE, jakość, dostępność oraz wydajność. Kolor wskaźnika
    zależy od przedziału wartości. Przyjmuje 3 argumenty id, value oraz
    title gdzie id to id diva w którym będzie rysowany wykres, value to
    wyświetlana wartość a title to wyświetlany tytuł wskaźnika.

-   **createOeeLineChart:** Generuje wykres liniowy pokazujący zmiany
    wskaźników OEE oraz jakości w czasie. Pzyjmuje 4 argumenty gdzie id
    to id, w którym będzie znajdować się wykres xData to wartości na osi
    X (w tym przypadku poszczególne dni) a oeeData i qualityData to
    wartości na osi Y (wartości wksaźnika OEE i jakości).

-   **createPieChart:** Tworzy wykres kołowy ilustrujący status
    produktów (np. Dobre, Niedobre, Anulowane). Funkcja przyjmuje 4
    argumenty id to id, w którym będzie znajdować się wykres,
    goodProducts to ilość wyrobów dobrych, badProducts to ilość wyrobów
    złych a canceledProducts to ilość wyrobów anulowanych.

## Pliki PHP

W projekcie występuje kilka plików PHP, które pełnią rolę konfiguracji,
logiki aplikacji oraz generowania interfejsu.

### `controller.php`

Plik `controller.php` zawiera główną logikę sterującą aplikacją. Może on
obsługiwać żądania HTTP, przetwarzać dane oraz kierować przepływem
informacji między frontendem a backendem.

### `dbconfig.php`

Plik `dbconfig.php` zawiera konfigurację połączenia z bazą danych, w tym
ustawienia takie jak:

-   Host bazy danych

-   Nazwa użytkownika

-   Hasło

-   Nazwa bazy danych

Plik ten jest wykorzystywany przez inne skrypty PHP do nawiązania
połączenia z bazą danych.

### `offcanvas.php`

Plik `offcanvas.php` odpowiada za generowanie elementów interfejsu
użytkownika, takich jak menu off-canvas czy panele boczne. Może być
używany do nawigacji lub wyświetlania dodatkowych opcji w aplikacji.

### `index.php`

Plik `index.php` stanowi główny punkt wejścia dla aplikacji webowej.
Jego zadania obejmują:

-   Inicjalizację sesji oraz konfigurację środowiska.

-   Łączenie części widokowych i modułów aplikacji, w tym dołączanie
    odpowiednich skryptów CSS i JavaScript.

-   Renderowanie dynamicznej zawartości strony, pobieranie danych z bazy
    lub innych źródeł oraz prezentowanie ich użytkownikowi.

### `sqlQueries.php`

Plik `sqlQueries.php` zawiera definicje zapytań SQL wykorzystywanych
przez aplikację. Do jego głównych zadań należy:

-   Przechowywanie szablonów zapytań SQL, które są wykorzystywane do
    pobierania, wstawiania, aktualizacji lub usuwania danych w bazie.

-   Umożliwienie łatwej modyfikacji zapytań w jednym miejscu, co
    przyczynia się do lepszej konserwacji kodu.

-   Integracja z modułami PHP, które wykonują te zapytania, aby zapewnić
    spójność i centralizację logiki dostępu do danych.

# Instalacja i konfiguracja

## Backend

1.  Zainstaluj wymagane biblioteki:

    ``` bash
    pip install python-dotenv schedule paho-mqtt pymysql
    ```

2.  Utwórz plik `.env` z konfiguracją połączenia do bazy danych:

    ``` bash
    DB_HOST=adres_serwera_bazy
    DB_USER=uzytkownik
    DB_PASSWORD=haslo
    DB_DATABASE=nazwa_bazy
    DB_PORT=3306
    ```

3.  Uruchom skrypty:

    -   `dailyDataInsert.py` – agregacja i wstawianie danych codziennie
        o 23:00.

    -   `dataCollector.py` – odbieranie wiadomości MQTT i zapisywanie
        danych do bazy.

## Frontend

1.  Dołącz plik `index.js` do strony HTML.

    ``` html
    <script src="index.js" defer></script>
    ```

2.  Upewnij się, że strona zawiera elementy HTML z odpowiednimi
    atrybutami (np. `data-json`), z których pobierane są dane do
    wykresów.

3.  Załaduj bibliotekę Plotly i skrypt js potrzebny do działania
    bootstrapa:

    ``` html
    <script src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    ```

4.  W sekcji head należy podpiąć css Bootstrapa:

    ``` html
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    ```

## PHP

1.  Upewnij się, że pliki `controller.php`, `dbconfig.php`,
    `offcanvas.php`, `index.php` oraz `sqlQueries.php` są umieszczone w
    odpowiednich katalogach projektu.

2.  Skonfiguruj serwer WWW tak, aby poprawnie interpretował pliki PHP.

3.  Przejrzyj plik `dbconfig.php` i zaktualizuj ustawienia bazy danych
    według potrzeb.

# Podsumowanie

System monitorowania wydajności maszyn integruje kilka technologii:

-   Skrypty Pythona (`dailyDataInsert.py` oraz `dataCollector.py`)
    odpowiadają za zbieranie, przetwarzanie i zapisywanie danych do
    bazy.

-   Skrypt JavaScript (`index.js`) przetwarza dane z bazy i generuje
    interaktywne wykresy przy użyciu biblioteki Plotly.

-   Komponenty PHP (`controller.php`, `dbconfig.php`, `offcanvas.php`,
    `index.php` oraz `sqlQueries.php`) wspierają logikę aplikacji,
    konfigurację połączenia z bazą oraz generowanie interfejsu
    użytkownika.

Dzięki powyższej integracji możliwe jest bieżące monitorowanie
kluczowych wskaźników (takich jak OEE, jakość, dostępność i wydajność),
co pozwala na szybkie reagowanie i podejmowanie decyzji opartych na
aktualnych danych.
