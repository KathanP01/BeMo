<?php

namespace App\Services;

use OpenAI;

class TicketClassifier
{
    public function classify(string $subject, string $body): array
    {
        if (!config('app.openai_classify_enabled', false)) {
            // Return mock data when AI is disabled
            $categories = ['Billing', 'Technical', 'Feature Request', 'General Inquiry'];
            $explanations = [
                'This appears to be related to payment issues.',
                'This seems to be a technical problem with the system.',
                'This looks like a request for a new feature.',
                'This is a general question about our services.'
            ];
            
            return [
                'category' => $categories[array_rand($categories)],
                'explanation' => $explanations[array_rand($explanations)],
                'confidence' => round(rand(70, 95) / 100, 2),
            ];
        }

        // Real AI implementation
        $client = OpenAI::client(config('services.openai.key'));
        
        $prompt = "Classify this support ticket into one of these categories: Billing, Technical, Feature Request, General Inquiry.\n\n";
        $prompt .= "Subject: {$subject}\n";
        $prompt .= "Body: {$body}\n\n";
        $prompt .= "Respond with a JSON object containing: category, explanation, confidence (0-1).";
        
        $response = $client->chat()->create([
            'model' => 'gpt-3.5-turbo',
            'messages' => [
                ['role' => 'system', 'content' => 'You are a support ticket classification system.'],
                ['role' => 'user', 'content' => $prompt],
            ],
            'max_tokens' => 150,
        ]);
        
        $result = json_decode($response->choices[0]->message->content, true);
        
        return [
            'category' => $result['category'] ?? 'General Inquiry',
            'explanation' => $result['explanation'] ?? 'Unable to determine category.',
            'confidence' => $result['confidence'] ?? 0.5,
        ];
    }
}