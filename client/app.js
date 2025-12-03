const API_BASE_URL = 'http://localhost:8080/api';

const registrationForm = document.getElementById('registrationForm');
const countrySelect = document.getElementById('country');
const departmentSelect = document.getElementById('department');
const municipalitySelect = document.getElementById('municipality');
const submitBtn = document.getElementById('submitBtn');
const refreshBtn = document.getElementById('refreshBtn');
const usersContainer = document.getElementById('usersContainer');
const successMessage = document.getElementById('successMessage');
const errorMessage = document.getElementById('errorMessage');
const langToggle = document.getElementById('langToggle');
const currentLangSpan = document.getElementById('currentLang');

const translations = {
    en: {
        appTitle: 'User Registration System',
        appSubtitle: 'Register users with geographic location tracking',
        registerTitle: 'Register New User',
        labelName: 'Full Name *',
        placeholderName: 'Enter full name',
        labelPhone: 'Phone Number *',
        placeholderPhone: '+1 555 123 4567',
        labelAddress: 'Address *',
        placeholderAddress: 'Enter full address',
        labelCountry: 'Country *',
        selectCountry: 'Select a country',
        labelDepartment: 'Department/State *',
        selectDepartment: 'Select a department',
        labelMunicipality: 'Municipality/City *',
        selectMunicipality: 'Select a municipality',
        btnRegister: 'Register User',
        btnRegistering: 'Registering...',
        msgSuccess: 'User registered successfully!',
        usersTitle: 'Registered Users',
        btnRefresh: 'Refresh',
        msgLoading: 'Loading users...',
        msgEmpty: 'No users registered yet',
        footerText: 'User Registration System | Technical Assessment | Built with C# .NET 8 & PostgreSQL'
    },
    es: {
        appTitle: 'Sistema de Registro de Usuarios',
        appSubtitle: 'Registrar usuarios con seguimiento de ubicación geográfica',
        registerTitle: 'Registrar Nuevo Usuario',
        labelName: 'Nombre Completo *',
        placeholderName: 'Ingrese nombre completo',
        labelPhone: 'Número de Teléfono *',
        placeholderPhone: '+57 300 123 4567',
        labelAddress: 'Dirección *',
        placeholderAddress: 'Ingrese dirección completa',
        labelCountry: 'País *',
        selectCountry: 'Seleccione un país',
        labelDepartment: 'Departamento/Estado *',
        selectDepartment: 'Seleccione un departamento',
        labelMunicipality: 'Municipio/Ciudad *',
        selectMunicipality: 'Seleccione un municipio',
        btnRegister: 'Registrar Usuario',
        btnRegistering: 'Registrando...',
        msgSuccess: '¡Usuario registrado exitosamente!',
        usersTitle: 'Usuarios Registrados',
        btnRefresh: 'Actualizar',
        msgLoading: 'Cargando usuarios...',
        msgEmpty: 'No hay usuarios registrados aún',
        footerText: 'Sistema de Registro de Usuarios | Prueba Técnica | Construido con C# .NET 8 y PostgreSQL | Jose Becerra'
    }
};

let currentLang = 'es';

document.addEventListener('DOMContentLoaded', () => {
    updateLanguage();
    loadCountries();
    loadUsers();
    setupEventListeners();
});

function setupEventListeners() {
    registrationForm.addEventListener('submit', handleFormSubmit);
    countrySelect.addEventListener('change', handleCountryChange);
    departmentSelect.addEventListener('change', handleDepartmentChange);
    refreshBtn.addEventListener('click', loadUsers);
    langToggle.addEventListener('click', toggleLanguage);
}

function toggleLanguage() {
    currentLang = currentLang === 'en' ? 'es' : 'en';
    updateLanguage();

    updateSelectPlaceholder(countrySelect, 'selectCountry');
    updateSelectPlaceholder(departmentSelect, 'selectDepartment');
    updateSelectPlaceholder(municipalitySelect, 'selectMunicipality');
}

function updateLanguage() {
    currentLangSpan.textContent = currentLang.toUpperCase();

    document.querySelectorAll('[data-i18n]').forEach(element => {
        const key = element.getAttribute('data-i18n');
        if (translations[currentLang][key]) {
            element.textContent = translations[currentLang][key];
        }
    });

    document.querySelectorAll('[data-placeholder]').forEach(element => {
        const key = element.getAttribute('data-placeholder');
        if (translations[currentLang][key]) {
            element.placeholder = translations[currentLang][key];
        }
    });
}

function updateSelectPlaceholder(selectElement, key) {
    const defaultOption = selectElement.querySelector('option[value=""]');
    if (defaultOption && translations[currentLang][key]) {
        defaultOption.textContent = translations[currentLang][key];
    }
}

async function loadCountries() {
    try {
        const response = await fetch(`${API_BASE_URL}/user/countries`);
        const result = await response.json();

        if (result.success && result.data) {
            populateSelect(countrySelect, result.data, 'id', 'name', 'selectCountry');
        }
    } catch (error) {
        console.error('Error loading countries:', error);
        showError('Failed to load countries');
    }
}

async function handleCountryChange(e) {
    const countryId = e.target.value;

    resetSelect(departmentSelect, 'selectDepartment');
    resetSelect(municipalitySelect, 'selectMunicipality');
    departmentSelect.disabled = !countryId;
    municipalitySelect.disabled = true;

    if (!countryId) return;

    try {
        const response = await fetch(`${API_BASE_URL}/user/departments/${countryId}`);
        const result = await response.json();

        if (result.success && result.data) {
            populateSelect(departmentSelect, result.data, 'id', 'name', 'selectDepartment');
            departmentSelect.disabled = false;
        }
    } catch (error) {
        console.error('Error loading departments:', error);
        showError('Failed to load departments');
    }
}

async function handleDepartmentChange(e) {
    const departmentId = e.target.value;

    resetSelect(municipalitySelect, 'selectMunicipality');
    municipalitySelect.disabled = !departmentId;

    if (!departmentId) return;

    try {
        const response = await fetch(`${API_BASE_URL}/user/municipalities/${departmentId}`);
        const result = await response.json();

        if (result.success && result.data) {
            populateSelect(municipalitySelect, result.data, 'id', 'name', 'selectMunicipality');
            municipalitySelect.disabled = false;
        }
    } catch (error) {
        console.error('Error loading municipalities:', error);
        showError('Failed to load municipalities');
    }
}

function resetSelect(selectElement, placeholderKey) {
    selectElement.innerHTML = `<option value="" data-i18n="${placeholderKey}">${translations[currentLang][placeholderKey]}</option>`;
}

function populateSelect(selectElement, data, valueKey, textKey, placeholderKey) {
    resetSelect(selectElement, placeholderKey);

    data.forEach(item => {
        const option = document.createElement('option');
        option.value = item[valueKey];
        option.textContent = item[textKey];
        selectElement.appendChild(option);
    });
}

async function handleFormSubmit(e) {
    e.preventDefault();

    hideMessages();

    const formData = new FormData(registrationForm);
    const userData = {
        name: formData.get('name'),
        phone: formData.get('phone'),
        address: formData.get('address'),
        countryId: parseInt(formData.get('countryId')),
        departmentId: parseInt(formData.get('departmentId')),
        municipalityId: parseInt(formData.get('municipalityId'))
    };

    setLoadingState(true);

    try {
        const response = await fetch(`${API_BASE_URL}/user/register`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        });

        const result = await response.json();

        if (response.ok && result.success) {
            showSuccess(translations[currentLang].msgSuccess);
            registrationForm.reset();

            departmentSelect.disabled = true;
            municipalitySelect.disabled = true;
            resetSelect(departmentSelect, 'selectDepartment');
            resetSelect(municipalitySelect, 'selectMunicipality');

            setTimeout(() => loadUsers(), 500);
        } else {
            const errorMsg = result.message || 'Failed to register user';
            const errors = result.errors ? result.errors.join(', ') : '';
            showError(`${errorMsg}${errors ? ': ' + errors : ''}`);
        }
    } catch (error) {
        console.error('Error registering user:', error);
        showError('An error occurred while registering the user');
    } finally {
        setLoadingState(false);
    }
}

async function loadUsers() {
    usersContainer.innerHTML = `
        <div class="loading-state">
            <span class="spinner-large"></span>
            <p>${translations[currentLang].msgLoading}</p>
        </div>
    `;

    try {
        const response = await fetch(`${API_BASE_URL}/user/all`);
        const result = await response.json();

        if (result.success && result.data) {
            displayUsers(result.data);
        } else {
            usersContainer.innerHTML = `<p class="empty-state">${translations[currentLang].msgEmpty}</p>`;
        }
    } catch (error) {
        console.error('Error loading users:', error);
        usersContainer.innerHTML = '<p class="error-state">Failed to load users</p>';
    }
}

function displayUsers(users) {
    if (!users || users.length === 0) {
        usersContainer.innerHTML = `<p class="empty-state">${translations[currentLang].msgEmpty}</p>`;
        return;
    }

    const usersHTML = users.map(user => `
        <div class="user-card">
            <div class="user-header">
                <div class="user-avatar">${user.userName.charAt(0).toUpperCase()}</div>
                <div class="user-info">
                    <h3 class="user-name">${escapeHtml(user.userName)}</h3>
                    <p class="user-phone">📞 ${escapeHtml(user.phone)}</p>
                </div>
            </div>
            <div class="user-details">
                <div class="detail-item">
                    <span class="detail-icon">📍</span>
                    <span class="detail-text">${escapeHtml(user.address)}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-icon">🌍</span>
                    <span class="detail-text">
                        ${escapeHtml(user.municipalityName)}, ${escapeHtml(user.departmentName)}, ${escapeHtml(user.countryName)}
                    </span>
                </div>
                <div class="detail-item">
                    <span class="detail-icon">📅</span>
                    <span class="detail-text">${formatDate(user.createdAt)}</span>
                </div>
            </div>
        </div>
    `).join('');

    usersContainer.innerHTML = usersHTML;
}

function setLoadingState(isLoading) {
    const btnText = submitBtn.querySelector('.btn-text');
    const btnLoader = submitBtn.querySelector('.btn-loader');

    submitBtn.disabled = isLoading;
    btnText.style.display = isLoading ? 'none' : 'inline';
    btnLoader.style.display = isLoading ? 'inline-flex' : 'none';
}

function showSuccess(message) {
    successMessage.querySelector('.alert-text').textContent = message;
    successMessage.style.display = 'flex';

    setTimeout(() => {
        successMessage.style.display = 'none';
    }, 5000);
}

function showError(message) {
    errorMessage.querySelector('.alert-text').textContent = message;
    errorMessage.style.display = 'flex';

    setTimeout(() => {
        errorMessage.style.display = 'none';
    }, 7000);
}

function hideMessages() {
    successMessage.style.display = 'none';
    errorMessage.style.display = 'none';
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString(currentLang === 'en' ? 'en-US' : 'es-ES', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}
